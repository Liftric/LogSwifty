//
//  Metadata.swift
//  LogSwifty
//
//  Created by Ben John on 23.12.17.
//

import Foundation

public struct Metadata {
    let level: Level
    let file: String
    let function: String
    let line: Int
    let timestamp: Date = Date()
    
    init(level: Level, file: String, function: String, line: Int) {
        self.level = level
        self.file = URL(fileURLWithPath: file).lastPathComponent
        self.function = function
        self.line = line
    }
}

extension Metadata: CustomStringConvertible {
    public var description: String {
        let desc = [
            "\(self.timestamp)",
            "[\(self.level)]",
            "\(self.file):\(self.line)",
            "\(self.function):"
        ]
        return desc.joined(separator: "\t")
    }
}
