//
//  ImageCachyUIImage.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/20/21.
//

import Foundation
import UIKit

private var imageUrlKey: Void?
private var imageSetKey: Void?
private let imageLoadHudTag = 99989

public extension UIImageView {
    var cacheImageUrl: URL? {
        get {
            return objc_getAssociatedObject(self, &imageUrlKey) as? URL
        }
        set {
            objc_setAssociatedObject(self, &imageUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var isImageSet: Bool {
        get {
            return (objc_getAssociatedObject(self, &imageSetKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &imageSetKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension UIImageView {
    func showLoading() {
        if let hud = self.viewWithTag(imageLoadHudTag) as? UIActivityIndicatorView {
            hud.startAnimating()
            return
        } else {
            let hud = UIActivityIndicatorView(style: .gray)
            hud.tag = imageLoadHudTag
            hud.center = center
            hud.hidesWhenStopped = true
            addSubview(hud)
            bringSubviewToFront(hud)
            hud.center = center
            hud.startAnimating()
        }
    }

    func hideLoading() {
        if let hud = self.viewWithTag(imageLoadHudTag) as? UIActivityIndicatorView {
            hud.stopAnimating()
            return
        }
    }
}

public extension UIImageView {
    private class CachyImageLoaderPar: NSObject {
        var url: URL!
        var isShowLoading: Bool!
        var completionBlock: ImageCacheImageCallback!
        init(url: URL, showLoading: Bool, completionBlock: @escaping ImageCacheImageCallback) {
            self.url = url
            isShowLoading = showLoading
            self.completionBlock = completionBlock
        }
    }

    func cacheImageLoad(_ url: URL,
                        isShowLoading: Bool,
                        completionBlock: @escaping ImageCacheImageCallback) {
        cacheImageUrl = url
        if isShowLoading {
            showLoading()
        }
        let loader = ImageCacheLoader()
        loader.loadWithURL(url) { [weak self] data, url in
            if isShowLoading {
                self?.hideLoading()
            }

            guard let _self = self, let cachyImageUrl = _self.cacheImageUrl, let image = UIImage(data: data) else {
                NSLog("no imageView")
                return
            }
            if cachyImageUrl.absoluteString != url.absoluteString {
                NSLog("url not match:\(cachyImageUrl),\(url)")
            } else {
                self?.setImageWith(image)
                completionBlock(image, url)
            }
        }
    }

    @objc
    fileprivate func setImageWith(_ image: UIImage) {
        self.image = image
        isImageSet = true
    }
}
