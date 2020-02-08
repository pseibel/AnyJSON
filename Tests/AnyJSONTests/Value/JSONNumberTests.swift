/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONNumberTests: XCTestCase {
    func testJsonNumberValue_withCorrectValueType_shouldReturnValue() {
        XCTAssertTrue((try Int(1).jsonNumber(Double.self)) == Double(1.0))
        XCTAssertTrue((try Int(1).jsonNumber(Int.self)) == Int(1))
        XCTAssertTrue((try Double(32).jsonNumber(Int.self)) == Int(32.0))
        XCTAssertTrue((try Double(32).jsonNumber(Double.self)) == Double(32.0))
    }
    
    func testJsonNumberValue_withIncorrectValueType_shouldThrowError() {
        XCTAssertThrowsError((try Double(32.5).jsonNumber(Int.self)) == Int(32.0))
    }

    static var allTests = [
        ("testJsonNumberValue_withCorrectValueType_shouldReturnValue",
         testJsonNumberValue_withCorrectValueType_shouldReturnValue),
        ("testJsonNumberValue_withIncorrectValueType_shouldThrowError",
         testJsonNumberValue_withIncorrectValueType_shouldThrowError)
    ]
}
