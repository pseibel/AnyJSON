/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public extension KeyedDecodingContainerProtocol {
    func decodeJSONObject(forKey key: Key) throws -> JSONObject {
        let container = try self.nestedContainer(keyedBy: JSONObjectKey.self, forKey: key)
        return try container.decodeAsJSONObject()
    }
    
    func decodeJSONArray(forKey key: Key) throws -> JSONArray {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decodeAllValuesAsJSONArray()
    }
    
    func decodeJSONRootValue(forKey key: Key) throws -> JSONRootValue {
        do {
            return try decodeJSONObject(forKey: key)
        } catch {}
        
        do {
            return try decodeJSONArray(forKey: key)
        } catch {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Not a valid JSON root value.")
        }
    }
}

extension KeyedDecodingContainerProtocol where Key == JSONObjectKey {
    func decodeAsJSONObject() throws -> JSONObject {
        return try allKeys.reduce([String: JSONValue]()) { (result, key) in
            var result = result
            result[key.stringValue] = try decodeJSONValue(for: key)
            return result
        }
    }
}

public extension KeyedDecodingContainerProtocol where Key == JSONObjectKey {
    func decodeJSONValue(for key: Key) throws -> JSONValue {
        do {
            return try self.decode(Int.self, forKey: key)
        } catch {}
        
        do {
            return try self.decode(Double.self, forKey: key)
        } catch {}
        
        do {
            return try self.decode(Bool.self, forKey: key)
        } catch {}
        
        do {
            return try self.decode(String.self, forKey: key)
        } catch {}
        
        do {
            if try self.decodeNil(forKey: key) {
                return JSONNull.null
            }
        } catch {}

        do {
            return try self.decodeJSONObject(forKey: key)
        } catch {}
        
        do {
            return try self.decodeJSONArray(forKey: key)
        } catch {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Not a valid JSON value.")
        }
    }
}
