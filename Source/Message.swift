//
//  Message.swift
//  LogSwifty
//
//  Created by Ben John on 30/12/2016.
//
//

import Foundation

public enum Level: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

public struct Message: CustomStringConvertible {
    public var description: String {
        // deal with multiline
        var stack = [String]()
        message.enumerateLines { line, _ in
            stack.append("\(self.metadata) \(line)")
        }
        return stack.joined(separator: "\n")
    }

    let metadata: Metadata
    let message: String

    init(_ body: [Any?], level: Level, file: String, function: String, line: Int) {
        self.metadata = Metadata(level: level, file: file, function: function, line: line)

        // deal with variadic parameter
        var unvariadic: String = ""
        for b in body {
            if let unwrapped = b {
                unvariadic += "\(unwrapped) "
                continue
            }
            unvariadic += "\(b) "
        }
        self.message = String(unvariadic.characters.dropLast())
    }

    public struct Metadata: CustomStringConvertible {
        public var description: String {
            let desc = [
                "\(self.timestamp)",
                "[\(self.level)]",
                "\(self.file):\(self.line)",
                "\(self.function):"
            ]
            return desc.joined(separator: "\t")
        }

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
}
