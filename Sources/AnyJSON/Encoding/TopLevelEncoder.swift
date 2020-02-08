/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public protocol TopLevelEncoder {
    associatedtype Output

    func encode<T>(_ value: T) throws -> Self.Output where T : Encodable
}

public extension TopLevelEncoder {
    func encode(_ value: JSONRootValue) throws -> Self.Output {
        return try self.encode(JSONRoot(value))
    }
}

extension JSONEncoder: TopLevelEncoder {}
extension PropertyListEncoder: TopLevelEncoder {}
