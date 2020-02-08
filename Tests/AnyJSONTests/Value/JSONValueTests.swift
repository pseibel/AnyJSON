/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONValueTests: XCTestCase {
    func testIsEqualTo_withDifferentJSONValueTypes_shouldBeFalse() {
        var firstValue: JSONValue = Double(1.3)
        var secondValue: JSONValue = String("Value")
        
        XCTAssertFalse(firstValue.isEqual(to: secondValue))
        
        firstValue = Double(1.3)
        secondValue = Int(5)
        
        XCTAssertFalse(firstValue.isEqual(to: secondValue))
        
        firstValue = Double(1.3)
        secondValue = [5]
        
        XCTAssertFalse(firstValue.isEqual(to: secondValue))
        
        firstValue = ["key": "value"]
        secondValue = [5]
        
        XCTAssertFalse(firstValue.isEqual(to: secondValue))
        
        
        firstValue = JSONNull.null
        secondValue = 7
        
        XCTAssertFalse(firstValue.isEqual(to: secondValue))
    }
    
    func testIsEqualTo_withEqualJSONValues_shouldBeTrue() {
        var firstValue: JSONValue = Double(1.3)
        var secondValue: JSONValue = Double(1.3)
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))
        
        firstValue = "test"
        secondValue = "test"
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))

        firstValue = Int(11)
        secondValue = Int(11)
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))
        
        firstValue = ["test", 5, 3.4]
        secondValue = ["test", 5, 3.4]
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))
        
        firstValue = ["key": "value"]
        secondValue = ["key": "value"]
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))
        
        firstValue = JSONNull.null
        secondValue = JSONNull.null
        
        XCTAssertTrue(firstValue.isEqual(to: secondValue))
    }
    
    func testIsEqualTo_withDifferentJSONValues_shouldBeFalse() {
        let firstDouble: JSONValue = Double(1.3)
        let secondDouble: JSONValue = Double(2.3)
        
        XCTAssertFalse(firstDouble.isEqual(to: secondDouble))
    }

    static var allTests = [
        ("testIsEqualTo_withDifferentJSONValueTypes_shouldBeFalse",
         testIsEqualTo_withDifferentJSONValueTypes_shouldBeFalse),
        ("testIsEqualTo_withEqualJSONValues_shouldBeTrue",
         testIsEqualTo_withEqualJSONValues_shouldBeTrue),
        ("testIsEqualTo_withDifferentJSONValues_shouldBeFalse", testIsEqualTo_withDifferentJSONValues_shouldBeFalse)
    ]
}
