//
//  Distributor.swift
//  LogSwifty
//
//  Created by Ben John on 12/08/16.
//
//

import Foundation

class Distributor {
    var loggers = [Logger]()

    func add(logger: Logger) {
        let contains = loggers.contains { needle -> Bool in
            return ObjectIdentifier.init(logger) == ObjectIdentifier.init(needle)
        }
        guard contains == false else { fatalError("A logger instance can not be added more than once") }
        loggers.append(logger)
    }

    func distribute(_ log: Message) {
        loggers.forEach { logger in
            guard logger.level <= log else { return }
            logger.log(log)
        }
    }

    func log(_ message: Message) {
        distribute(message)
    }
}
