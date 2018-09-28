// LogSwiftyTagTests.swift
//
// - Authors:
// Ben John
//
// - Date: 28.09.18
//
// 


import XCTest
@testable import LogSwifty

fileprivate extension Log {
    var tag: Tag? {
        return "WithATag"
    }
}

class LogSwiftyTagTests: XCTestCase {
    let bugsnag = BugsnagLogger()
    let warningAndError = WarningAndErrorLogger()

    override func setUp() {
        super.setUp()
        Log.add(logger: Log.debug)
        Log.add(logger: EmptyLogger())
        Log.add(logger: bugsnag)
        Log.add(logger: warningAndError)
    }

    override func tearDown() {
        warningAndError.empty()
        bugsnag.empty()
        Log.empty()
        super.tearDown()
    }

    func testWarningAndErrorLogger_shouldContainTag() {
        Log.w("test")
        guard let last = warningAndError.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("WithATag"))
        XCTAssertTrue(last.contains("test"))
        XCTAssertTrue(last.contains("[warning]"))
    }
}
