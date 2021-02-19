//
//  Constants.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation

struct APPURL{
    
    private static let Domain = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
    private static let Route = "/default"
    private static let BaseURL = Domain + Route
    static let classifieds = APPURL.BaseURL + "/dynamodb-writer"
    
}

