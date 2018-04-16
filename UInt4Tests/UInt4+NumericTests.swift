//
//    UInt4+NumericTests.swift
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

class UInt4_NumericTests: XCTestCase {
    
    let a:UInt4 = 0
    let b:UInt4 = 1
    let c:UInt4 = 2
    let d:UInt4 = 3
    
    let x:UInt4 = 10
    let y:UInt4 = 12
    let z:UInt4 = 14
    
    var m:UInt4 = 5
    
    override func setUp() {
        super.setUp()
        
        // reset vars
        m = 5
    }
    
    func testInitExactly() {
        
        let a = UInt4(exactly: 0)
        let b = UInt4(exactly: 15)
        let c = UInt4(exactly: -1)
        let d = UInt4(exactly: 16)
        
        XCTAssertNotNil(a)
        XCTAssertNotNil(b)
        XCTAssertNil(c)
        XCTAssertNil(d)

    }
    
    func testMagnitude() {
        XCTAssertEqual(x.magnitude, 10)
        XCTAssertEqual(y.magnitude, 12)
        XCTAssertEqual(z.magnitude, 14)
    }
    
    func testMultiply() {
        XCTAssertEqual(a * b, 0)
        XCTAssertEqual(c * c, 4)
        XCTAssertEqual(b * z, 14)
        XCTAssertEqual(c * d, 6)
    }
    
    func testMultiplyInOut() {
        m *= d
        XCTAssertEqual(m, 15)
    }
    
    func testAddition() {
        XCTAssertEqual(a + b, 1)
        XCTAssertEqual(d + y, 15)
        XCTAssertEqual(c + d, 5)
    }
    
    func testAdditionInOut() {
        m += d
        XCTAssertEqual(m, 8)
    }
    
    func testSubtraction() {
        XCTAssertEqual(d - a, 3)
        XCTAssertEqual(z - x, 4)
        XCTAssertEqual(y - c, 10)
    }
    
    func testSubtractionInOut() {
        m -= d
        XCTAssertEqual(m, 2)
    }
}
