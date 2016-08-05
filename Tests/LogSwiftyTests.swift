//
//  LogSwiftyTests.swift
//  LogSwiftyTests
//
//  Created by Ben John on 05/08/16.
//
//

import XCTest
@testable import LogSwifty

class LogSwiftyTests: XCTestCase {
    func testOutputMessage() {
        let loggableObject = CrazyClass()
        loggableObject.doSomethingCrazy()
        let last = LogStack.logs.last
        XCTAssertTrue((last?.contains("something crazy happened!"))!)
    }
}

struct LogStack {
    static var logs = [String]()
}

extension Logger {
    func logMessage(message: String) {
        LogStack.logs.append(message)
    }
}

class CrazyClass: Loggable {
    func doSomethingCrazy() {
        log(.info, message: "something crazy happened!")
    }
}
