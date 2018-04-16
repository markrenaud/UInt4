//
//    UInt4+StrideableTests.swift
//    UInt4Tests
//
//    MIT License
//
//    Copyright (c) 2018 Mark Renaud
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import XCTest
@testable import UInt4

class UInt4_StrideableTests: XCTestCase {
    
    let a:UInt4 = 0
    let b:UInt4 = 1
    let c:UInt4 = 2
    let d:UInt4 = 3
    
    let x:UInt4 = 10
    let y:UInt4 = 12
    let z:UInt4 = 14
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAdvancedBy() {
        XCTAssertEqual(c.advanced(by: 2), 4)
        XCTAssertEqual(d.advanced(by: 5), 8)
    }
    
    func testDistanceTo() {
        XCTAssertEqual(c.distance(to: z), 12)
        XCTAssertEqual(z.distance(to: c), -12)
        XCTAssertEqual(a.distance(to: a), 0)
        XCTAssertEqual(x.distance(to: a), -10)
    }
    
}
