//
//  Classifieds.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit
import SwiftyJSON


public struct Ads {
    var createdAt : String?
    var imageIds : [String]?
    var imageUrls : [String]?
    var imageUrlsThumbnails : [String]?
    var name : String?
    var price : String?
    var uid : String?
    
    init(createdAt:String , name:String, price:String, uid: String,imageIds : [String] = [],imageUrls : [String] = [],imageUrlsThumbnails : [String] = []) {
        self.imageUrls = imageUrls
        self.imageUrlsThumbnails = imageUrlsThumbnails
        self.imageIds = imageIds
        self.createdAt = createdAt
        self.name = name
        self.price = price
        self.uid = uid
    }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        imageIds = [String]()
        let imageIdsArray = json["image_ids"].arrayValue
        for imageIdsJson in imageIdsArray{
            imageIds?.append(imageIdsJson.stringValue)
        }
        imageUrls = [String]()
        let imageUrlsArray = json["image_urls"].arrayValue
        for imageUrlsJson in imageUrlsArray{
            self.imageUrls?.append(imageUrlsJson.stringValue)
        }
        imageUrlsThumbnails = [String]()
        let imageUrlsThumbnailsArray = json["image_urls_thumbnails"].arrayValue
        for imageUrlsThumbnailsJson in imageUrlsThumbnailsArray{
            self.imageUrlsThumbnails?.append(imageUrlsThumbnailsJson.stringValue)
        }
        
        
        name = json["name"].stringValue
        price = json["price"].stringValue
        uid = json["uid"].stringValue
    }
    
    init(managedObject:AdsModel) {
        name = managedObject.name ?? ""
        price = managedObject.price ?? ""
        createdAt = managedObject.createdAt ?? ""
        uid = managedObject.uid ?? ""
        imageIds = [String]()
        imageUrls = [String]()
        if managedObject.imagesUrl?.count ?? 0 > 0 {
            for imagesUrls in managedObject.imagesUrl?.allObjects as! [ImagesURL]  {
                self.imageUrls?.append(imagesUrls.imageUrls ?? "")
            }
        }
        imageUrlsThumbnails = [String]()
        if managedObject.imagesThumbnail?.count ?? 0 > 0 {
            for imagesThumbnailUrls in managedObject.imagesThumbnail?.allObjects as! [ImagesThumbnails]  {
                self.imageUrlsThumbnails?.append(imagesThumbnailUrls.imageUrlsThumbnails ?? "")
            }
        }
    }
    
}


