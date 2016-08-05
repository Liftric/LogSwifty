//
//  LogSwifty.swift
//  LogSwifty
//
//  Created by Ben John on 05/08/16.
//
//

import Foundation

public enum LogLevel: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

struct Message {
    let body: String
    let metadata: Metadata

    init(_ message: String, level: LogLevel, file: String, function: String, line: Int) {
        self.body = message
        self.metadata = Metadata(level: level, file: file, function: function, line: line)
    }

    struct Metadata {
        let level: LogLevel
        let file: String
        let function: String
        let line: Int
        let timestamp: Date = Date()

        init(level: LogLevel, file: String, function: String, line: Int) {
            self.level = level
            self.file = URL(fileURLWithPath: file).lastPathComponent
            self.function = function
            self.line = line
        }
    }
}

extension Loggable {
    var dateFormatter: DateFormatter {
        return DateFormatter()
    }

    func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let message = Message(message, level: level, file: file, function: function, line: line)
        print(formatMessage(message))
    }

    func formatMessage(_ message: Message) -> String {
        return "\(message.metadata.timestamp)\t[\(message.metadata.level)]\t\(message.metadata.file):\(message.metadata.line)\t\(message.metadata.function): \(message.body)"
    }
}

public protocol Loggable {
    func log(_ level: LogLevel, message: String, file: String, function: String, line: Int)
}
