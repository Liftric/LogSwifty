//
//  Distributor.swift
//  LogSwifty
//
//  Created by Ben John on 12/08/16.
//
//

import Foundation

enum Level: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

struct Message {
    let body: String
    let metadata: Metadata

    init(_ message: String, level: Level, file: String, function: String, line: Int) {
        self.body = message
        self.metadata = Metadata(level: level, file: file, function: function, line: line)
    }

    struct Metadata {
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

class Distributor {
    var loggers = [Logger]()

    func add(logger: Logger) {
        loggers.append(logger)
    }

    func distribute(log: String) {
        loggers.forEach { logger in
            logger.log(message: log)
        }
    }

    func log(message: Message) {
        distribute(log: format(message: message))
    }

    func format(message: Message) -> String {
        return "\(message.metadata.timestamp)\t[\(message.metadata.level)]\t\(message.metadata.file):\(message.metadata.line)\t\(message.metadata.function): \(message.body)"
    }
}
