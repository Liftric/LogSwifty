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

extension String {
    func contains(find: String) -> Bool{
        print(self)
        print(find)
        return self.range(of: find) != nil
    }
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
        XCTAssertTrue(last.contains("XMLParsingError"))
        XCTAssertTrue(last.contains("Code=1"))
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
