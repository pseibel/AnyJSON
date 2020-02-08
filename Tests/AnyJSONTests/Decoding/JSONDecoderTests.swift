/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import XCTest
@testable import AnyJSON

final class JSONDecoderTests: XCTestCase {
    func testDecodeJSONRootValue_withJSONObject() {
        
        let jsonString = """
{
    "first": "string",
    "second": 2.0,
    "third": 3,
    "fourth": [
        1,
        "two",
        3.0
    ],
    "fifth": {
        "key": "value"
    },
    "sixth": true,
    "seventh": null
}
"""
        
        let data = jsonString.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        
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
            let jsonObject = (try jsonDecoder.decodeJSONRootValue(from: data)) as! JSONObject
            
            XCTAssertTrue(jsonObject.isEqual(to: expectedResult))
        } catch {
            XCTFail("JSON should be parsed")
        }
    }
    
    func testDecodeJSONRootValue_withJSONArray() {
            
            let jsonString = """
    [1.0,
    "someString",
    false,
    4.6,
    {
        "first": "string",
        "second": 2.0,
        "third": 3,
        "fourth": [
            1,
            "two",
            3.0
        ],
        "fifth": {
            "key": "value"
        },
        "sixth": true,
        "seventh": null
    },
    ["a", true, 9.5, 2]
    ]
    """
            
            let data = jsonString.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            
        let expectedResult: JSONArray = [1.0, "someString", false, 4.6, [
                "first": "string",
                "second": 2.0,
                "third": 3,
                "fourth": [1, "two", 3.0],
                "fifth": ["key": "value"],
                "sixth": true,
                "seventh": JSONNull.null
                ],
                ["a", true, 9.5, 2]
        ]
            
            do {
                let jsonArray = (try jsonDecoder.decodeJSONRootValue(from: data)) as! JSONArray
                
                XCTAssertTrue(jsonArray.isEqual(to: expectedResult))
            } catch {
                XCTFail("JSON should be parsed")
            }
        }
    
    
    func testDecodableObjectWithJSONProperty() {
            
            let jsonString = """
    {
        "first": "string",
        "second": 2.0,
        "third": 3,
        "fourth": [
            1,
            "two",
            3.0
        ],
        "fifth": {
            "key": "value"
        }
    }
    """
            
        struct OuterObject: Decodable {
            let first: String
            let second: Double
            let third: Int
            let fourth: JSONArray
            let fifth: JSONObject
        
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                first = try container.decode(String.self, forKey: .first)
                second = try container.decode(Double.self, forKey: .second)
                third = try container.decode(Int.self, forKey: .third)
                fourth = try container.decodeJSONArray(forKey: .fourth)
                fifth = try container.decodeJSONObject(forKey: .fifth)
            }
            
            private enum CodingKeys: String, CodingKey {
                case first
                case second
                case third
                case fourth
                case fifth
            }
        }
        
            let data = jsonString.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            
            let expectedResult: JSONObject = [
                "first": "string",
                "second": 2.0,
                "third": 3,
                "fourth": [1, "two", 3.0],
                "fifth": ["key": "value"]
                ]
            
            do {
                let outerObject = try jsonDecoder.decode(OuterObject.self, from: data)
                
                XCTAssertTrue(outerObject.fourth.isEqual(to: expectedResult["fourth"] as! JSONArray))
                XCTAssertTrue(outerObject.fifth.isEqual(to: expectedResult["fifth"] as! JSONObject))
            } catch {
                XCTFail("JSON should be parsed")
            }
        }
    

    static var allTests = [
        ("testDecodeJSONRootValue_withJSONObject", testDecodeJSONRootValue_withJSONObject),
        ("testDecodeJSONRootValue_withJSONArray", testDecodeJSONRootValue_withJSONArray),
        ("testDecodableObjectWithJSONProperty", testDecodableObjectWithJSONProperty)
    ]
}
