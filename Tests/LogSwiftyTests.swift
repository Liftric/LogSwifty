//
//  LogSwiftyTests.swift
//  LogSwiftyTests
//
//  Created by Ben John on 05/08/16.
//
//

import XCTest
@testable import LogSwifty

class EmptyLogger: Logger {
    func log(message: String) {
        // .done
    }
}

class BugsnagLogger: Logger {
    var logs = [String]()

    func log(message: String) {
        logs.append(message)
    }
}

class LogSwiftyTests: XCTestCase {
    func testBugsnagLogger() {
        let bugsnag = BugsnagLogger()

        Log.add(logger: DebugLogger())
        Log.add(logger: EmptyLogger())
        Log.add(logger: bugsnag)

        Log.v("test")

        guard let last = bugsnag.logs.last else {
            XCTFail()
            return
        }

        XCTAssertTrue(last.contains("test"))
        XCTAssertTrue(last.contains("[verbose]"))
        XCTAssertFalse(last.contains("test2"))
    }
}
