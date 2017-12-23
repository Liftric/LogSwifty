//
//  Level.swift
//  LogSwifty
//
//  Created by Ben John on 23.12.17.
//

import Foundation

public enum Level: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

extension Level {
    public static func <=(lhs: Level, rhs: Message) -> Bool {
        return lhs.rawValue <= rhs.metadata.level.rawValue
    }
}
