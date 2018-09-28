//
//  Message.swift
//  LogSwifty
//
//  Created by Ben John on 30/12/2016.
//
//

import Foundation

public struct Message {
    var metadata: Metadata
    let message: String
    
    init(_ body: [Any?], level: Level, tag: Tag?, file: StaticString, function: StaticString, line: UInt) {
        self.metadata = Metadata(level: level, tag: tag, file: file, function: function, line: line)
        
        // deal with variadic parameter
        var unvariadic: String = ""
        for b in body {
            // the reason for having `[Any?]` and unwrapping here is that otherwise
            // it would lead to debug messages like `Optional(...)` even though we
            // do not have any optionals.
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
