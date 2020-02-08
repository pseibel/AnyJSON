/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

extension UnkeyedDecodingContainer {
    mutating func decodeAllValuesAsJSONArray() throws -> JSONArray {
        guard let count = count else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "Not a vaild JSON array")
        }
        
        var array: [JSONValue] = []
        
        while currentIndex < count {
            array.append(try decodeJSONValue())
        }
        
        return array
    }
}

public extension UnkeyedDecodingContainer {
    mutating func decodeJSONArray() throws -> JSONArray {
        var container = try nestedUnkeyedContainer()
        return try container.decodeAllValuesAsJSONArray()
    }
    
    mutating func decodeJSONObject() throws -> JSONObject {
        let container = try nestedContainer(keyedBy: JSONObjectKey.self)
        return try container.decodeAsJSONObject()
    }
    
    mutating func decodeJSONValue() throws -> JSONValue {
        do {
            return try self.decode(Int.self)
        } catch {}
        
        do {
            return try self.decode(Double.self)
       } catch {}
        
       do {
           return try self.decode(Bool.self)
       } catch {}
       
       do {
           return try self.decode(String.self)
       } catch {}
        
        do {
            if try self.decodeNil() {
                return JSONNull.null
            }
        } catch {}
       
       do {
            return try self.decodeJSONObject()
       } catch {}
       
       do {
            return try self.decodeJSONArray()
       } catch {
           throw DecodingError.dataCorruptedError(in: self, debugDescription: "Not a valid JSON value.")
       }
    }
}
