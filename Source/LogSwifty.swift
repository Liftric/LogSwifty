//
//  LogSwifty.swift
//  LogSwifty
//
//  Created by Ben John on 05/08/16.
//
//

import Foundation

public protocol Logger: class {
    func log(_ message: String)
}

open class Log {
    // MARK: - Accessible logging methods

    open class func v(_ body: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(Message(body, level: Level.verbose, file: file, function: function, line: line))
    }

    open class func d(_ body: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(Message(body, level: Level.debug, file: file, function: function, line: line))
    }

    open class func i(_ body: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(Message(body, level: Level.info, file: file, function: function, line: line))
    }

    open class func w(_ body: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(Message(body, level: Level.warning, file: file, function: function, line: line))
    }

    open class func e(_ body: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(Message(body, level: Level.error, file: file, function: function, line: line))
    }

    private static let distributor = Distributor()
    open class func add(logger: Logger) {
        distributor.add(logger: logger)
    }

    open class func empty() {
        distributor.loggers.removeAll()
    }
}

public extension Log {
    // MARK: - stdout logger

    static var debug: Logger {
        struct Singleton {
            static let debug = DebugLogger()
        }
        return Singleton.debug
    }
}

class DebugLogger: Logger {
    func log(_ message: String) {
        print(message)
    }
}
