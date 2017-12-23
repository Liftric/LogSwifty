//
//  Message.swift
//  LogSwifty
//
//  Created by Ben John on 30/12/2016.
//
//

import Foundation

public struct Message {
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
            unvariadic += "\(b ?? "") "
        }
        self.message = String(unvariadic.dropLast())
    }
}

extension Message: CustomStringConvertible {
    public var description: String {
        // deal with multiline
        var stack = [String]()
        message.enumerateLines { line, _ in
            stack.append("\(self.metadata) \(line)")
        }
        return stack.joined(separator: "\n")
    }
}
