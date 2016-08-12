//
//  LogSwifty.swift
//  LogSwifty
//
//  Created by Ben John on 05/08/16.
//
//

import Foundation

public protocol Logger {
    func log(message: String)
}

public class Log {
    public class func v(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(message, level: Level.verbose, file: file, function: function, line: line))
    }

    public class func d(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(message, level: Level.debug, file: file, function: function, line: line))
    }

    public class func i(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(message, level: Level.info, file: file, function: function, line: line))
    }

    public class func w(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(message, level: Level.warning, file: file, function: function, line: line))
    }

    public class func e(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        distributor.log(message: Message(message, level: Level.error, file: file, function: function, line: line))
    }

    private static let distributor = Distributor()

    public class func add(logger: Logger) {
        distributor.add(logger: logger)
    }
}

public class DebugLogger: Logger {
    public func log(message: String) {
        print(message)
    }
}
