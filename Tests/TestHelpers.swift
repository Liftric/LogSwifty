//
//  TestHelpers.swift
//  LogSwiftyTests
//
//  Created by Ben John on 23.12.17.
//

import Foundation

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
