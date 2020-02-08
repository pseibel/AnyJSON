/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public protocol JSONValue {}
public protocol JSONRootValue: JSONValue {}

extension Bool: JSONValue {}
extension String: JSONValue {}

extension JSONValue {
    public func isEqual(to otherValue: JSONValue) -> Bool {
        if let leftBool = self as? Bool,
            let rightBool = otherValue as? Bool {
            return leftBool == rightBool
        } else if let leftInt = self as? Int {
            if let rightInt = otherValue as? Int  {
                return leftInt == rightInt
            } else if let rightDouble = otherValue as? Double {
                return Double(leftInt) == rightDouble
            } else {
                return false
            }
        } else if let leftDouble = self as? Double {
            if let rightDouble = otherValue as? Double {
                return leftDouble == rightDouble
            } else if let rightInt = otherValue as? Int {
                return leftDouble == Double(rightInt)
            } else {
                return false
            }
        } else if let leftString = self as? String,
            let rightString = otherValue as? String {
            return leftString == rightString
        } else if let _ = self as? JSONNull,
            let _ = otherValue as? JSONNull {
            return true
        } else if let leftArray = self as? JSONArray,
            let rightArray = otherValue as? JSONArray {
            guard leftArray.count == rightArray.count else { return false }
            for (index, value) in leftArray.enumerated() {
                guard value.isEqual(to: rightArray[index]) else { return false }
            }
            return true
        } else if let leftObject = self as? JSONObject,
                let rightObject = otherValue as? JSONObject {
            guard leftObject.count == rightObject.count else { return false }
            for (key, value) in leftObject {
                guard let rightValue = rightObject[key], value.isEqual(to: rightValue) else { return false }
            }
            return true
        } else {
            return false
        }
    }
}
