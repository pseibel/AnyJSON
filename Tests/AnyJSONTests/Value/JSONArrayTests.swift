/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONArrayTests: XCTestCase {
    func testJsonValueAtIndex_withCorrectValueType_shouldReturnValue() {
        let jsonArray: JSONArray = [
            1.3,
            1,
            true,
            "string",
            [1, "two", 3.1, false],
            ["key": "value"],
            JSONNull.null
        ]

        XCTAssertTrue((try jsonArray.jsonValue(Double.self, at: 0)) == 1.3)
        XCTAssertTrue((try jsonArray.jsonValue(Int.self, at: 1)) == 1)
        // Since a value 1 in JSON could be a Int or a Double both should be valid
        XCTAssertTrue((try jsonArray.jsonValue(Double.self, at: 1)) == 1.0)
        XCTAssertTrue((try jsonArray.jsonValue(Bool.self, at: 2)) == true)
        XCTAssertTrue((try jsonArray.jsonValue(String.self, at: 3)) == "string")
        XCTAssertTrue((try jsonArray.jsonValue(JSONArray.self, at: 4)).isEqual(to: [1, "two", 3.1, false]))
        XCTAssertTrue((try jsonArray.jsonValue(JSONObject.self, at: 5)).isEqual(to: ["key": "value"]))
        XCTAssertTrue((try jsonArray.jsonValue(JSONNull.self, at: 6)).isEqual(to: JSONNull.null))

    }
    
    func testJsonValueAtIndex_withIncorrectValueType_shouldThrowError() {
        let jsonObject: JSONArray = [
            1.3,
            1,
            true,
            "string",
            [1, "two", 3.1, false],
            ["key": "value"],
            JSONNull.null
        ]
        
        XCTAssertThrowsError((try jsonObject.jsonValue(Int.self, at: 0)) == 1)
        XCTAssertThrowsError((try jsonObject.jsonValue(String.self, at: 1)) == "string")
        XCTAssertThrowsError((try jsonObject.jsonValue(JSONArray.self, at: 2)).isEqual(to: ["string", 1]))
        XCTAssertThrowsError((try jsonObject.jsonValue(JSONObject.self, at: 3)).isEqual(to: ["key": "value"]))
        XCTAssertThrowsError((try jsonObject.jsonValue(Double.self, at: 4)) == 1.3)
        XCTAssertThrowsError((try jsonObject.jsonValue(Bool.self, at: 5)) == true)
        XCTAssertThrowsError((try jsonObject.jsonValue(String.self, at: 6)) == "null")
    }

    static var allTests = [
        ("testJsonValueAtIndex_withCorrectValueType_shouldReturnValue",
         testJsonValueAtIndex_withCorrectValueType_shouldReturnValue),
        ("testJsonValueAtIndex_withIncorrectValueType_shouldThrowError",
         testJsonValueAtIndex_withIncorrectValueType_shouldThrowError)
    ]
}
