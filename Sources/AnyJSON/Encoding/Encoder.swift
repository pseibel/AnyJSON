/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public extension Encoder {
    func encode(jsonRootValue: JSONRootValue) throws {
        if let array = jsonRootValue as? JSONArray {
            var container = self.unkeyedContainer()
            try container.encodeAll(from: array)
        } else if let object = jsonRootValue as? JSONObject {
            var container = self.container(keyedBy: JSONObjectKey.self)
            try container.encodeAll(from: object)
        }
    }
}
