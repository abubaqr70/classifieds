//
//  Extensions.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//


import Foundation
import UIKit

extension DateFormatter {
    
    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
        
        let formats: [String] = [
            "yyyy-MM-dd",
            "yyyy-MM-dd HH:mm:ss.SSSSSSSSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss +zzzz",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS +zzzz",
            "dd-MMM-yy HH:mm"        ]
        for format in formats {
            self.dateFormat = format
            if let date = self.date(from: dateString) {
                return date
            }
        }
        return nil
    }
    
    static var sharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        dateFormatter.timeZone = TimeZone.current//TimeZone(abbreviation: "UTC")
        
        return dateFormatter
    }()
    
}


extension NSDate {
    
    static func relativePast(for date : Date) -> String {
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
        let components = Calendar.current.dateComponents(units, from: date, to: Date())
        if components.year! > 0 {
            return "\(components.year!) " + (components.year! > 1 ? "years ago" : "year ago")
            
        } else if components.month! > 0 {
            return "\(components.month!) " + (components.month! > 1 ? "months ago" : "month ago")
            
        } else if components.weekOfYear! > 0 {
            return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "weeks ago" : "week ago")
            
        } else if (components.day! > 0) {
            let str = "days ago"
            return (components.day! > 1 ? "\(components.day!) \(str)" : "Yesterday")
            
        } else if components.hour! > 0 {
            return "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")
            
        } else if components.minute! > 0 {
            return "\(components.minute!) " + (components.minute! > 1 ? "minutes ago" : "minute ago")
            
        } else {
            return  (components.second! > 1 ? "\(components.second!) " + "seconds ago" : "Just now")
        }
    }
    
}
extension UIColor {
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}



