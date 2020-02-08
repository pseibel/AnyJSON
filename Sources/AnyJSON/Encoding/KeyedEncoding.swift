/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

extension KeyedEncodingContainerProtocol where Key == JSONObjectKey {
    mutating func encodeAll(from jsonObject: JSONObject) throws {
        for (key, value) in jsonObject {
            try encode(value, forKey: JSONObjectKey(key))
        }
    }
}

public extension KeyedEncodingContainerProtocol where Key == JSONObjectKey {
    mutating func encode(_ jsonObject: JSONObject, forKey key: Key) throws {
        var container = self.nestedContainer(keyedBy: JSONObjectKey.self, forKey: key)
        try container.encodeAll(from: jsonObject)
    }
    
    mutating func encode(_ jsonArray: JSONArray, forKey key: Key) throws {
        var container = self.nestedUnkeyedContainer(forKey: key)
        try container.encodeAll(from: jsonArray)
    }
    
    mutating func encode(_ jsonValue: JSONValue, forKey key: Key) throws {
        if let intValue = jsonValue as? Int {
            try self.encode(intValue, forKey: key)
        } else if let doubleValue = jsonValue as? Double {
            try self.encode(doubleValue, forKey: key)
        } else if let bool = jsonValue as? Bool {
            try self.encode(bool, forKey: key)
        } else if let string = jsonValue as? String {
            try self.encode(string, forKey: key)
        } else if let _ = jsonValue as? JSONNull {
            try self.encodeNil(forKey: key)
        } else if let object = jsonValue as? JSONObject {
            try self.encode(object, forKey: key)
        } else if let array = jsonValue as? JSONArray {
            try self.encode(array, forKey: key)
        }
    }
}
