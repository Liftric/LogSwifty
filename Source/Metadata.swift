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
    let line: UInt
    let timestamp: Date = Date()
    
    init(level: Level, file: StaticString, function: StaticString, line: UInt) {
        self.level = level
        self.file = URL(fileURLWithPath: String(file)).lastPathComponent
        self.function = String(function)
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

extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}
