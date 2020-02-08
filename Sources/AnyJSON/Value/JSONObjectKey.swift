/**
*  AnyJSON
*  Copyright (c) Philipp Seibel 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

public struct JSONObjectKey: CodingKey {
    public var stringValue: String
    
    public init?(intValue: Int) {
        stringValue = String(describing: intValue)
    }
        
    public init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public init(_ stringValue: String) {
        self.stringValue = stringValue
    }
    
    public var intValue: Int? {
        return Int(stringValue)
    }
}
