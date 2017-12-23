//
//  Loggers.swift
//  LogSwiftyTests
//
//  Created by Ben John on 23.12.17.
//

import Foundation
@testable import LogSwifty

class EmptyLogger: Logger {
    func log(_ message: Message) {
        // .done
    }
}

class BugsnagLogger: Logger {
    var logs = [String]()
    
    func log(_ message: Message) {
        logs.append("\(message)")
    }
    
    func empty() {
        logs.removeAll()
    }
}

class WarningAndErrorLogger: Logger {
    var logs = [String]()
    var level: Level = .warning
    
    func log(_ message: Message) {
        logs.append("\(message)")
    }
    
    func empty() {
        logs.removeAll()
    }
}
