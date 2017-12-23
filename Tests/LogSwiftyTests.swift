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

    func testErrorLogging() {
        Log.e(XMLParsingError.init(line: 10, column: 10, kind: .internalError))
        guard let last = bugsnag.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("XMLParsingError.ErrorKind.internalError"))
    }

    func testMultilineLogging() {
        let multiline = [
            "Multiline Test",
            "Blablablabla",
            "xyzxyzxyz"
        ]
        Log.d(multiline.joined(separator: "\n"))
        XCTAssertEqual(1, bugsnag.logs.count)
        guard let last = bugsnag.logs.last else {
            XCTFail("missing log")
            return
        }
        var idx = 0
        last.enumerateLines { line, _ in
            XCTAssertTrue(line.contains(multiline[idx]))
            idx += 1
        }
    }

    func testOptionalLogging() {
        let optional = URL(string: "github.io")
        Log.d(optional as Any)
        guard let last = bugsnag.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("github.io"))
        XCTAssertFalse(last.contains("Optional(github.io)"))
    }

    func testVariadicLogging() {
        let foo = Date()
        let bar = Data()
        Log.d(foo, bar)
        guard let last = bugsnag.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("+0000"))
        XCTAssertTrue(last.contains("0 bytes"))
    }

    func testBugsnagLogger() {
        Log.v("test")
        guard let last = bugsnag.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("test"))
        XCTAssertTrue(last.contains("[verbose]"))
        XCTAssertFalse(last.contains("test2"))
    }
    
    func testWarningAndErrorLogger_shouldContainWarning() {
        Log.w("test")
        guard let last = warningAndError.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("test"))
        XCTAssertTrue(last.contains("[warning]"))
    }
    
    func testWarningAndErrorLogger_shouldContainError() {
        Log.e("test")
        guard let last = warningAndError.logs.last else {
            XCTFail("missing log")
            return
        }
        XCTAssertTrue(last.contains("test"))
        XCTAssertTrue(last.contains("[error]"))
    }
    
    func testWarningAndErrorLogger_shouldNotContainInfo() {
        Log.i("test")
        guard warningAndError.logs.isEmpty else {
            XCTFail("has log but should not contain any")
            return
        }
    }
}
