/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

import XCTest
@testable import AnyJSON

final class JSONNullTests: XCTestCase {
    func testEquatable_shouldBeTrue() {
        XCTAssertEqual(JSONNull(), JSONNull())
        XCTAssertEqual(JSONNull.null, JSONNull())
    }

    static var allTests = [
        ("testEquatable_shouldBeTrue",
         testEquatable_shouldBeTrue)
    ]
}
