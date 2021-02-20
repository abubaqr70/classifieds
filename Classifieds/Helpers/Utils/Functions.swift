//
//  Functions.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import SwiftyJSON
import SwiftMessages

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
    static func noInternetConnection(status:Bool){
        
        if status == true{
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
            
            let view: MessageView
            view = try! SwiftMessages.viewFromNib()
            
            view.configureContent(title: "", body: "Please check your internet connection", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in
                
                SwiftMessages.hide()
                
            })
            view.accessibilityPrefix = "error"
            view.configureDropShadow()
            view.button?.isHidden = true
            
            var config = SwiftMessages.defaultConfig
            config.presentationStyle = .top
            config.presentationContext = .window(windowLevel: .statusBar)
            config.preferredStatusBarStyle = .lightContent
            config.interactiveHide = false
            config.duration = .forever
            view.configureTheme(backgroundColor: UIColor.red, foregroundColor: UIColor.white, iconImage: nil, iconText: nil)
            
            config.dimMode = .gray(interactive: true)
            SwiftMessages.show(config: config, view: view)
            
        }else{
            SwiftMessages.hide()
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
            
        }
        
    }
}

