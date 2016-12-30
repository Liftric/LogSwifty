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

struct XMLParsingError: Error {
    enum ErrorKind {
        case invalidCharacter
        case mismatchedTag
        case internalError
    }

    let line: Int
    let column: Int
    let kind: ErrorKind
}

class LogSwiftyTests: XCTestCase {
    let bugsnag = BugsnagLogger()

    override func setUp() {
        super.setUp()
        Log.add(logger: Log.debug)
        Log.add(logger: EmptyLogger())
        Log.add(logger: bugsnag)
    }

    override func tearDown() {
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
}
