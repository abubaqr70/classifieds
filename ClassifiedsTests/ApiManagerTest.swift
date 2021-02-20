//
//  ApiManagerTest.swift
//  ClassifiedsTests
//
//  Created by Muhammad Abubaqr on 2/20/21.
//

import XCTest
@testable import Classifieds

class ApiManagerTest: XCTestCase {

    func testApiManger() {
        ApiManager.getRequest(with: APPURL.classifieds, parameters: nil, completion: { (result) in
            switch result {
            case .success(let result):
                print(result)
                XCTAssertNotNil(result,result["results"].stringValue)
            case .failure(let error):
                print(error)
                XCTAssertNotNil(error)
            }
        })
    }

}
