//
//  Functions.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import SwiftyJSON

class Functions: NSObject {
    
    class func saveJSON(json: JSON, key:String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }
    
    class func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    class func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
    }
    
    static func GetDateStringReturnDate( dateString : String ,formate : String) -> NSDate {
        
        if dateString != ""{
            let strDate = dateString
            let dateFormatter = DateFormatter()
            let date = dateFormatter.dateFromMultipleFormats(fromString: strDate)
            dateFormatter.dateFormat = formate
            return date! as NSDate
        }
        else{
            return Date() as NSDate
        }
    }
}

