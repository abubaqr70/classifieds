//
//  ImageCacheLoader.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/20/21.
//

import Foundation
import UIKit

public typealias ImageCacheCallback = (Data, URL) -> Void
public typealias ImageCacheImageCallback = (UIImage, URL) -> Void
public typealias ImageCacheCallbackList = [ImageCacheCallback]

open class ImageCacheLoaderManager {
    public static let shared: ImageCacheLoaderManager = {
        let instance = ImageCacheLoaderManager()
        return instance
    }()
    
    fileprivate var cache: ImageCache
    private var fetchList: [String: ImageCacheCallbackList] = [:]
    private var fetchListOperationQueue: DispatchQueue = DispatchQueue(label: "image-cache.Mohammad-Abubaqr",
                                                                       attributes: DispatchQueue.Attributes.concurrent)
    private var sessionConfiguration: URLSessionConfiguration!
    private var sessionQueue: OperationQueue!
    fileprivate lazy var defaultSession: URLSession! = URLSession(configuration:
        self.sessionConfiguration, delegate: nil,
                                   delegateQueue: self.sessionQueue)
    
    public func configure(memoryCapacity: Int = 30 * 1024 * 1024,
                          maxConcurrentOperationCount: Int = 10,
                          timeoutIntervalForRequest: Double = 3,
                          expiryDate: ExpiryDate = .everyWeek,
                          isOnlyInMemory: Bool = false,
                          isSupportingSecureCodingSaving: Bool = true) {
        cache.totalCostLimit = memoryCapacity
        cache.expiration = expiryDate
        
        ImageCache.isOnlyInMemory = isOnlyInMemory
        ImageCache.isSupportingSecureCodingSaving = isSupportingSecureCodingSaving
        
        sessionQueue = OperationQueue()
        sessionQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
        sessionQueue.name = "image-cache.Mohammad.Abubaqr"
        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
        sessionConfiguration.timeoutIntervalForRequest = timeoutIntervalForRequest
    }
    
    private init(memoryCapacity: Int = 30 * 1024 * 1024,
                 maxConcurrentOperationCount: Int = 100,
                 timeoutIntervalForRequest: Double = 10,
                 expiryDate: ExpiryDate = .everyWeek) {
        cache = ImageCache()
        configure(memoryCapacity: memoryCapacity,
                  maxConcurrentOperationCount: maxConcurrentOperationCount,
                  timeoutIntervalForRequest: timeoutIntervalForRequest,
                  expiryDate: expiryDate)
    }
}

extension ImageCacheLoaderManager {
    fileprivate func readFetch(_ key: String) -> ImageCacheCallbackList? {
        return fetchList[key]
    }
    
    fileprivate func addFetch(_ key: String, callback: @escaping ImageCacheCallback) -> Bool {
        var skip = false
        let list = fetchList[key]
        if list != nil {
            skip = true
        }
        fetchListOperationQueue.sync(flags: .barrier, execute: {
            if var fList = list {
                fList.append(callback)
                self.fetchList[key] = fList
            } else {
                self.fetchList[key] = [callback]
            }
        })
        return skip
    }
    
    fileprivate func removeFetch(_ key: String) {
        _ = fetchListOperationQueue.sync(flags: .barrier) {
            self.fetchList.removeValue(forKey: key)
        }
    }
    
    fileprivate func clearFetch() {
        fetchListOperationQueue.async(flags: .barrier) {
            self.fetchList.removeAll()
        }
    }
}

extension ImageCacheLoaderManager {
    public func clear() {
        cache.clear()
        sessionConfiguration.urlCache?.removeAllCachedResponses()
    }
}

// MARK: - CachyLoader

open class ImageCacheLoader: NSObject {
    var task: URLSessionTask?
    public override init() {
        super.init()
    }
}

extension ImageCacheLoader {
    fileprivate func cacheKeyFromUrl(url: URL) -> String? {
        let path = url.absoluteString
        let cacheKey = path
        return cacheKey
    }
    
    fileprivate func dataFromFastCache(cacheKey: String) -> Data? {
        return ImageCacheLoaderManager.shared.cache.get(forKey: cacheKey)
    }
    
    public func loadWithURLRequest(_ urlRequest: URLRequest,
                                   isRefresh: Bool = false,
                                   expirationDate: Date? = nil,
                                   callback: @escaping ImageCacheCallback) {
        guard let url = urlRequest.url else {
            return
        }
        load(url: url,
             urlRequest: urlRequest,
             isRefresh: isRefresh,
             expirationDate: expirationDate,
             callback: callback)
    }
    
    public func loadWithURL(_ url: URL,
                            isRefresh: Bool = false,
                            expirationDate: Date? = nil,
                            callback: @escaping ImageCacheCallback) {
        load(url: url,
             isRefresh: isRefresh,
             expirationDate: expirationDate,
             callback: callback)
    }
    
    private func load(url: URL,
                      urlRequest: URLRequest? = nil,
                      isRefresh: Bool = false,
                      expirationDate: Date? = nil,
                      callback: @escaping ImageCacheCallback) {
        guard let fetchKey = self.cacheKeyFromUrl(url: url as URL) else {
            return
        }
        if !isRefresh {
            if let data = self.dataFromFastCache(cacheKey: fetchKey) {
                callback(data, url)
                return
            }
        }
        let cacheCallback = {
            (data: Data) -> Void in
            if let fetchList = ImageCacheLoaderManager.shared.readFetch(fetchKey) {
                ImageCacheLoaderManager.shared.removeFetch(fetchKey)
                DispatchQueue.main.async {
                    for f in fetchList {
                        f(data, url)
                    }
                }
            }
        }
        let skip = ImageCacheLoaderManager.shared.addFetch(fetchKey, callback: callback)
        if skip {
            return
        }
        let session = ImageCacheLoaderManager.shared.defaultSession
        let request = urlRequest ?? URLRequest(url: url)
        task = session?.dataTask(with: request, completionHandler: { data, _, _ in
            guard let data = data else {
                return
            }
            let object = ImageCacheObject(value: data as NSData, key: fetchKey, expirationDate: expirationDate)
            ImageCacheLoaderManager.shared.cache.add(object: object)
            cacheCallback(data)
        })
        task?.resume()
    }
}

extension ImageCacheLoader {
    public func cancelTask() {
        guard let _task = self.task else {
            return
        }
        if _task.state == .running || _task.state == .running {
            _task.cancel()
        }
    }
}

