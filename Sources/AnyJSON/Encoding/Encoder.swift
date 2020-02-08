/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Encoder {
    func encode(jsonValue: JSONValue) throws {
        if let array = jsonValue as? JSONArray {
            var container = self.unkeyedContainer()
            try container.encodeAll(from: array)
        } else if let object = jsonValue as? JSONObject {
            var container = self.container(keyedBy: JSONObjectKey.self)
            try container.encodeAll(from: object)
        }
    }
}
