/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONEncoderTests: XCTestCase {
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    func testEncodeJSONRootValue_withJSONObject() {
    
        let expectedResult: JSONObject = [
        "first": "string",
        "second": 2.0,
        "third": 3,
        "fourth": [1, "two", 3.0],
        "fifth": ["key": "value"],
        "sixth": true,
        "seventh": JSONNull.null
        ]
        
        
        
        
        
        do {
            let data = try jsonEncoder.encode(expectedResult)
            let jsonObject = (try jsonDecoder.decodeJSONRootValue(from: data)) as! JSONObject
            
            XCTAssertTrue(jsonObject.isEqual(to: expectedResult))
        } catch {
            XCTFail("JSON should be parsed")
        }
    }
    
    func testEncodeJSONRootValue_withJSONArray() {
        let expectedResult: JSONArray = [1.0, "someString", false, 4.6, [
                "first": "string",
                "second": 2.0,
                "third": 3,
                "fourth": [1, "two", 3.0],
                "fifth": ["key": "value"]
                ],
                ["a", true, 9.5, 2],
                JSONNull.null
        ]
            
            do {
                let data = try jsonEncoder.encode(expectedResult)
                let jsonArray = (try jsonDecoder.decodeJSONRootValue(from: data)) as! JSONArray
                
                XCTAssertTrue(jsonArray.isEqual(to: expectedResult))
            } catch {
                XCTFail("JSON should be parsed")
            }
        }
    

    static var allTests = [
        ("testEncodeJSONRootValue_withJSONObject",
         testEncodeJSONRootValue_withJSONObject),
        ("testEncodeJSONRootValue_withJSONArray",
         testEncodeJSONRootValue_withJSONArray)
    ]
}
