//
//  FunctionsTest.swift
//  ClassifiedsTests
//
//  Created by Muhammad Abubaqr on 2/20/21.
//

@testable import Classifieds
import XCTest
import SwiftyJSON
class FunctionsTest: XCTestCase {
    
    func testFunctionsClass(){
        ///Save Json Function Test
        let json:JSON = ["name":"abubaqr","age":"23"]
        XCTAssertNoThrow(Functions.saveJSON(json: json, key: "abubaqr"))
        
        ///Get Json with Key Function Test
        let jsonWithKey = Functions.getJSON("abubaqr")
        XCTAssert((jsonWithKey != nil), "Json Exsist")
        
        ///Checking Internet Availability Test
        let status = Reachability.isConnectedToNetwork()
        XCTAssertTrue(status)
        
        ///Converting Date string to with custom formats test
        let date = "2019-02-24 04:04:17.566515"
        let formateDate = Functions.GetDateStringReturnDate(dateString: date, formate: "h:mm a, MMM d,yyyy")
        XCTAssertNotNil(formateDate)
    }

}
