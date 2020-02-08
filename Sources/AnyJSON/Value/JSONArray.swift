/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Array: JSONRootValue, JSONValue where Element == JSONValue {
    public func jsonValue<V: JSONValue>(_ type: V.Type, at index: Index) throws -> V {
        guard let result = self[index] as? V else {
            if let number = self[index] as? JSONNumber {
                if type == Int.self {
                    return try number.jsonNumber(Int.self) as! V
                } else if type == Double.self {
                    return try number.jsonNumber(Double.self) as! V
                } else {
                    throw AnyJSONError.unsupportedJSONNumberType
                }
            }
            throw AnyJSONError.typeMismatch
        }
        return result
    }
}


public typealias JSONArray = Array<JSONValue>
