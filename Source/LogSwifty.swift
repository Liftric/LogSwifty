//
//  LogSwifty.swift
//  LogSwifty
//
//  Created by Ben John on 05/08/16.
//
//

import Foundation

public protocol Logger: class {
    var level: Level { get }
    
    func log(_ message: Message)
}

/// Default protocol implementation.
extension Logger {
    var level: Level {
        return .verbose
    }
}

public typealias Tag = String

open class Log {
    // MARK: - Accessible logging methods
    open class func v(tag: Tag? = nil, _ body: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        distributor.log(Message(body, level: .verbose, tag: tag, file: file, function: function, line: line))
    }

    open class func d(tag: Tag? = nil, _ body: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        distributor.log(Message(body, level: .debug, tag: tag, file: file, function: function, line: line))
    }

    open class func i(tag: Tag? = nil, _ body: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        distributor.log(Message(body, level: .info, tag: tag, file: file, function: function, line: line))
    }

    open class func w(tag: Tag? = nil, _ body: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        distributor.log(Message(body, level: .warning, tag: tag, file: file, function: function, line: line))
    }

    open class func e(tag: Tag? = nil, _ body: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        distributor.log(Message(body, level: .error, tag: tag, file: file, function: function, line: line))
    }

    private static let distributor = Distributor()
    open class func add(logger: Logger) {
        distributor.add(logger: logger)
    }

    open class func add(loggers: [Logger]) {
        loggers.forEach { distributor.add(logger: $0) }
    }

    open class func empty() {
        distributor.loggers.removeAll()
    }
}

class DebugLogger: Logger {
    // MARK: - stdout logger
    func log(_ message: Message) {
        print(message)
    }
}

public extension Log {
    static var debug: Logger {
        struct Singleton {
            static let debug = DebugLogger()
        }
        return Singleton.debug
    }
}
