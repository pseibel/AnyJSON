/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

struct JSONRoot: Codable {
    let rootValue: JSONRootValue
    
    init(_ rootValue: JSONRootValue) {
        self.rootValue = rootValue
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: JSONObjectKey.self)
            self.rootValue = try container.decodeAsJSONObject()
        } catch {
            var container = try decoder.unkeyedContainer()
            self.rootValue = try container.decodeAllValuesAsJSONArray()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        try encoder.encode(jsonValue: rootValue)
    }
}
