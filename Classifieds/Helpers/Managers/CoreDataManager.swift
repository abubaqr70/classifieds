//
//  CoreDataManager.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//


import Foundation
import CoreData
import SwiftyJSON
import UIKit

class CoreDataManager: NSObject {
    
    
    static var ads:[Ads]?
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class var context : NSManagedObjectContext {
        return getContext()
    }
    
    class func saveAdsInDb(with json: JSON){
        let listAds = AdsModel(context: context)
        listAds.name = json["name"].stringValue
        listAds.price = json["price"].stringValue
        listAds.uid = json["uid"].stringValue
        listAds.createdAt = json["created_at"].stringValue
        if json["image_urls"].arrayValue.count > 0{
            for imageUrlsArray in json["image_urls"].arrayValue {
                let images = ImagesURL(context:context)
                images.imageUrls = imageUrlsArray.stringValue
                listAds.addToImagesUrl(images)
            }
        }
        if json["image_urls_thumbnails"].arrayValue.count > 0{
            for imageUrlsThumbnailsArray in json["image_urls_thumbnails"].arrayValue {
                let imagesThumb = ImagesThumbnails(context:context)
                imagesThumb.imageUrlsThumbnails = imageUrlsThumbnailsArray.stringValue
                listAds.addToImagesThumbnail(imagesThumb)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    class func fetchAdsList() -> [Ads]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<AdsModel> = AdsModel.fetchRequest()
        var objList:[Ads]?
        do {
            let team = try context.fetch(fetchRequest)
            
            var arr = [Ads]()
            
            for objList in team{
                arr.append(Ads(managedObject: objList))
            }
            objList = arr
            return objList
            
        }catch {
            return objList
        }
    }
    
    class func resetAllRecords(in entity : String) 
    {
        
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
            {
                try context.execute(deleteRequest)
                try context.save()
            }
        catch
        {
            print ("There was an error")
        }
        
    }
    class func someEntityExists(id: String,entityName:String,requestedId:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(requestedId) = %@", id)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try context.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
}

