//
//  ApiManager.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum VoidResult {
    case success(result:JSON)
    case failure(NSError)
}



struct errorCode{
    /**
     501 mean session expired. Need to login again
     */
    static var loginAgain = 501
    /**
     200 mean sucess response
     */
    static var success = 200
    /**
     401 mean permission id denied
     */
    static var permissionDenied = 401
    
}



class ApiManager: NSObject {
    
    class func headers() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        return headers
    }
    
    class func getRequest(with url: String,parameters: [String:Any]?, completion: @escaping (_ result: VoidResult) -> ())
    {
        print(url)
        AF.request(url,method: .get, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers:ApiManager.headers()).responseJSON { (response:AFDataResponse<Any>) in
            if let jsonObject = response.value
            {
                let json = JSON(jsonObject)
                completion(.success(result: json))
            } else if let error = response.error {
                completion(.failure(error as NSError))
            } else {
                fatalError("No error, no failure")
            }
        }
    }
}






