/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public typealias JSONObject = Dictionary<String, JSONValue>

extension Dictionary: JSONRootValue, JSONValue where Key == String, Value == JSONValue {
    public func jsonValue<V: JSONValue>(_ type: V.Type, forKey key: Key) throws -> V {
        guard let result = self[key] as? V else {
            if let number = self[key] as? JSONNumber {
                if type == Int.self {
                    return try number.jsonNumber(Int.self) as! V
                } else if type == Double.self {
                    return try number.jsonNumber(Double.self) as! V
                }
            }
            throw AnyJSONError.typeMismatch
        }
        return result
    }
}
