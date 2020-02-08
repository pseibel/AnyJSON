/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public protocol TopLevelDecoder {
    associatedtype Input

    func decode<T>(_ type: T.Type, from: Self.Input) throws -> T where T : Decodable
}

public extension TopLevelDecoder {
    func decodeJSONRootValue(from input: Input) throws -> JSONRootValue {
        return try self.decode(JSONRoot.self, from: input).rootValue
    }
}

extension JSONDecoder: TopLevelDecoder {}
extension PropertyListDecoder: TopLevelDecoder {}
