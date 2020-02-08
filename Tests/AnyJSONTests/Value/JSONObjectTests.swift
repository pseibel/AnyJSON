/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONObjectTests: XCTestCase {
    func testJsonValueForKey_withCorrectValueType_shouldReturnValue() {
        let jsonObject: JSONObject = [
            "double": 1.3,
            "int": 1,
            "bool": true,
            "string": "string",
            "array": [1, "two", 3.1, false],
            "object": ["key": "value"]
        ]
        
        XCTAssertTrue((try jsonObject.jsonValue(Double.self, forKey: "double")) == 1.3)
        XCTAssertTrue((try jsonObject.jsonValue(Int.self, forKey: "int")) == 1)
        XCTAssertTrue((try jsonObject.jsonValue(Bool.self, forKey: "bool")) == true)
        XCTAssertTrue((try jsonObject.jsonValue(String.self, forKey: "string")) == "string")
        XCTAssertTrue((try jsonObject.jsonValue(JSONArray.self, forKey: "array")).isEqual(to: [1, "two", 3.1, false]))
        XCTAssertTrue((try jsonObject.jsonValue(JSONObject.self, forKey: "object")).isEqual(to: ["key": "value"]))
        // Since a value 1 in JSON could be a Int or a Double both should be valid
        XCTAssertTrue((try jsonObject.jsonValue(Double.self, forKey: "int")) == 1.0)
    }
    
    func testJsonValueForKey_withIncorrectValueType_shouldThrowError() {
        let jsonObject: JSONObject = [
            "double": 1.3,
            "int": 1,
            "bool": true,
            "string": "string",
            "array": [1, "two", 3.1, false],
            "object": ["key": "value"]
        ]
        
        XCTAssertThrowsError((try jsonObject.jsonValue(Int.self, forKey: "double")) == 1)
        XCTAssertThrowsError((try jsonObject.jsonValue(String.self, forKey: "int")) == "string")
        XCTAssertThrowsError((try jsonObject.jsonValue(JSONArray.self, forKey: "bool")).isEqual(to: ["string", 1]))
        XCTAssertThrowsError((try jsonObject.jsonValue(JSONObject.self, forKey: "string")).isEqual(to: ["key": "value"]))
        XCTAssertThrowsError((try jsonObject.jsonValue(Bool.self, forKey: "array")) == true)
        XCTAssertThrowsError((try jsonObject.jsonValue(Double.self, forKey: "object")) == 1.3)
    }

    static var allTests = [
        ("testJsonValueForKey_withCorrectValueType_shouldReturnValue", testJsonValueForKey_withCorrectValueType_shouldReturnValue),
        ("testJsonValueForKey_withIncorrectValueType_shouldThrowError", testJsonValueForKey_withIncorrectValueType_shouldThrowError)
    ]
}
