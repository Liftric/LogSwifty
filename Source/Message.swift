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
    public let description: String

    let metadata: Metadata
    let message: String

    init(_ body: [Any?], level: Level, file: String, function: String, line: Int) {
        self.metadata = Metadata(level: level, file: file, function: function, line: line)
        self.message = Formatter.createMessage(body: body)
        self.description = Formatter.createDescription(message: self.message, metadata: self.metadata)
    }

    public struct Metadata: CustomStringConvertible {
        public let description: String

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

            // create description
            let prefix = [
                "\(self.timestamp)",
                "[\(self.level)]",
                "\(self.file):\(self.line)",
                "\(self.function):"
            ]
            self.description = prefix.joined(separator: "\t")
        }
    }

    struct Formatter {
        static func createMessage(body: [Any?]) -> String {
            // deal with variadic parameter
            var unvariadic: String = ""
            for b in body {
                if let unwrapped = b {
                    unvariadic += "\(unwrapped) "
                    continue
                }
                unvariadic += "\(b) "
            }
            return String(unvariadic.characters.dropLast())
        }

        static func createDescription(message: String, metadata: Metadata) -> String {
            // deal with multiline
            var stack = [String]()
            message.enumerateLines { line, _ in
                let stringRepresentable = "\(metadata) \(line)"
                stack.append(stringRepresentable)
            }
            return stack.joined(separator: "\n")
        }
    }
}
