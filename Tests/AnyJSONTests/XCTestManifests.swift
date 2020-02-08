/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        // Decoding
        testCase(JSONDecoderTests.allTests),
        // Encoding
        testCase(JSONEncoderTests.allTests),
        // Value
        testCase(JSONArrayTests.allTests),
        testCase(JSONNumberTests.allTests),
        testCase(JSONObjectTests.allTests),
        testCase(JSONValueTests.allTests),
    ]
}
#endif
