/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

extension UnkeyedEncodingContainer {
    mutating func encodeAll(from jsonArray: JSONArray) throws {
        for value in jsonArray {
            try self.encode(value)
        }
    }
}

public extension UnkeyedEncodingContainer {
    mutating func encode(_ jsonObject: JSONObject) throws {
        var container = self.nestedContainer(keyedBy: JSONObjectKey.self)
        try container.encodeAll(from: jsonObject)
    }
    
    mutating func encode(_ jsonArray: JSONArray) throws {
        var container = self.nestedUnkeyedContainer()
        try container.encodeAll(from: jsonArray)
    }
    
    mutating func encode(_ jsonValue: JSONValue) throws {
        if let intValue = jsonValue as? Int {
            try self.encode(intValue)
        } else if let doubleValue = jsonValue as? Double {
            try self.encode(doubleValue)
        } else if let bool = jsonValue as? Bool {
            try self.encode(bool)
        } else if let string = jsonValue as? String {
            try self.encode(string)
        } else if let _ = jsonValue as? JSONNull {
            try self.encodeNil()
        } else if let object = jsonValue as? JSONObject {
            try self.encode(object)
        } else if let array = jsonValue as? JSONArray {
            try self.encode(array)
        }
    }
}
