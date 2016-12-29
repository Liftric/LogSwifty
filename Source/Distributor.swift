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
    let metadata: Metadata
    var body: String = ""

    init(_ body: [Any?], level: Level, file: String, function: String, line: Int) {
        self.metadata = Metadata(level: level, file: file, function: function, line: line)
        guard body.count > 0 else { return }
        for b in body {
            if let unwrapped = b {
                self.body += "\(unwrapped) "
                continue
            }
            self.body += "\(b) "
        }
        self.body = String(self.body.characters.dropLast())
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
        let contains = loggers.contains { needle -> Bool in
            return ObjectIdentifier.init(logger) == ObjectIdentifier.init(needle)
        }
        guard contains == false else { fatalError("A logger instance can not be added more than once") }
        loggers.append(logger)
    }

    func distribute(_ log: String) {
        loggers.forEach { logger in
            logger.log(log)
        }
    }

    func log(_ message: Message) {
        distribute(format(message))
    }

    func format(_ message: Message) -> String {
        var stack = [String]()

        let prefix = [
            "\(message.metadata.timestamp)",
            "[\(message.metadata.level)]",
            "\(message.metadata.file):\(message.metadata.line)",
            "\(message.metadata.function):"
        ]
        let metadata = prefix.joined(separator: "\t")

        message.body.enumerateLines { (line, _) in
            let stringRepresentable = "\(metadata) \(line)"
            stack.append(stringRepresentable)
        }

        return stack.joined(separator: "\n")
    }
}
