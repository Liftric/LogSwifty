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
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let loggableObject = CrazyClass()
        loggableObject.doSomethingCrazy()
    }
}

class CrazyClass: Loggable {
    func doSomethingCrazy() {
        log(.info, message: "something crazy happened!")
    }
}
