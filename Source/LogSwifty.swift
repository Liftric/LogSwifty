//
//  LogSwifty.swift
//  LogSwifty
//
//  Created by Ben John on 05/08/16.
//
//

import Foundation

public protocol Logger: class {
    func log(message: String)
}

public class Log {
    // MARK: - Accessible logging methods

    public class func v(_ body: AnyObject?, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(body, level: Level.verbose, file: file, function: function, line: line))
    }

    public class func d(_ body: AnyObject?, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(body, level: Level.debug, file: file, function: function, line: line))
    }

    public class func i(_ body: AnyObject?, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(body, level: Level.info, file: file, function: function, line: line))
    }

    public class func w(_ body: AnyObject?, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(body, level: Level.warning, file: file, function: function, line: line))
    }

    public class func e(_ body: AnyObject?, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(body, level: Level.error, file: file, function: function, line: line))
    }

    private static let distributor = Distributor()
    public class func add(logger: Logger) {
        distributor.add(logger: logger)
    }

    public class func empty() {
        distributor.loggers.removeAll()
    }
}

extension Log {
    // MARK: - stdout logger

    static var debug: Logger {
        struct Singleton {
            static let debug = DebugLogger()
        }
        return Singleton.debug
    }
}

public class DebugLogger: Logger {
    public func log(message: String) {
        print(message)
    }
}
