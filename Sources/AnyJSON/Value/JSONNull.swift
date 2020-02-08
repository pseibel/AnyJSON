//
//  File.swift
//  
//
//  Created by Philipp Seibel on 08.02.20.
//

import Foundation

public struct JSONNull: JSONValue, Equatable {
    public static let null = JSONNull()
    
    public static func ==(lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
}
