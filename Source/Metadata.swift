//
//  Metadata.swift
//  LogSwifty
//
//  Created by Ben John on 23.12.17.
//

import Foundation

public struct Metadata {
    let level: Level
    let tag: Tag?
    let file: String
    let function: String
    let line: UInt
    let timestamp: Date = Date()
    
    init(level: Level, tag: Tag?, file: StaticString, function: StaticString, line: UInt) {
        self.level = level
        self.tag = tag
        self.file = URL(fileURLWithPath: String(describing: file)).lastPathComponent
        self.function = String(describing: function)
        self.line = line
    }
}

extension Metadata: CustomStringConvertible {
    public var description: String {
        let desc = [
            "\(self.timestamp)",
            "[\(self.level)]",
            "(\(self.tag ?? ""))",
            "\(self.file):\(self.line)",
            "\(self.function):"
        ]
        return desc.joined(separator: "\t")
    }
}
