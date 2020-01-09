//
//  TestUtils.swift
//  CodableAPIClientTests
//
//  Created by Koji Murata on 2020/01/09.
//

import XCTest

extension String {
    fileprivate var lines: [String] {
        var lines = [String]()
        enumerateLines { (line, _) in lines.append(line) }
        return lines
    }
}

func AssertEqual<T: Equatable & CustomStringConvertible>(expected: T, actual: T, _ title: String) {
    if expected == actual {
        XCTAssert(true, title)
    } else {
        let expectedLines = expected.description.lines
        let actualLines = actual.description.lines
        
        var lineDiffs = [String]()
        for i in 0..<expectedLines.count {
            if expectedLines[i] == actualLines[i] { continue }
            lineDiffs.append("expected \"\(expectedLines[i])\" but was \"\(actualLines[i])\".")
        }
        
        XCTAssert(false, title + "\n" + lineDiffs.joined(separator: "\n"))
    }
}
