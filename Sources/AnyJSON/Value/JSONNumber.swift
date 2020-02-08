/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public protocol JSONNumber: JSONValue {
    init?(exactly double: Double)
    init(_ int: Int)
    func jsonNumber<V: JSONNumber>(_ type: V.Type) throws -> V
}

extension Int: JSONNumber {
    public func jsonNumber<V: JSONNumber>(_ type: V.Type) throws -> V {
        return V(self)
    }
}

extension Double: JSONNumber {
    public func jsonNumber<V: JSONNumber>(_ type: V.Type) throws -> V {
        guard let result = V(exactly: self) else {
            throw AnyJSONError.typeMismatch
        }
        return result
    }
}
