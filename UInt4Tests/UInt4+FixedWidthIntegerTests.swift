//
//    UInt4+FixedWidthIntegerTests.swift
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

class UInt4_FixedWidthIntegerTests: XCTestCase {
  
    func testBitWidth() {
        XCTAssertEqual(UInt4().bitWidth, 4)
    }
    
    func testAddingReportingOverflow() {
        let resultA = UInt4(12).addingReportingOverflow(UInt4(3))
        XCTAssertEqual(resultA.partialValue, UInt4(15))
        XCTAssertEqual(resultA.overflow, false)
        
        let resultB = UInt4(14).addingReportingOverflow(UInt4(3))
        // remember - if overflowing by 2, first overflow is 0, second is 1
        XCTAssertEqual(resultB.partialValue, UInt4(1))
        XCTAssertEqual(resultB.overflow, true)
    }
    
    func testSubtractingReportingOverflow() {
        let resultA = UInt4(3).subtractingReportingOverflow(UInt4(1))
        XCTAssertEqual(resultA.partialValue, UInt4(2))
        XCTAssertEqual(resultA.overflow, false)

        let resultB = UInt4(1).subtractingReportingOverflow(UInt4(3))
        // remember - 0 is a value, 1 --> 0 --> 15 --> 14
        XCTAssertEqual(resultB.partialValue, 14)
        XCTAssertEqual(resultB.overflow, true)
    }
    
    func testMultipliedReportingOverflow() {
        let resultA = UInt4(0).multipliedReportingOverflow(by: UInt4(14))
        XCTAssertEqual(resultA.partialValue, UInt4(0))
        XCTAssertEqual(resultA.overflow, false)

        let resultB = UInt4(12).multipliedReportingOverflow(by: UInt4(2))
        // remember - if overflowing by 2, first overflow is 0, second is 1, etc
        XCTAssertEqual(resultB.partialValue, UInt4(8))
        XCTAssertEqual(resultB.overflow, true)

        let resultC = UInt4(2).multipliedReportingOverflow(by: UInt4(3))
        XCTAssertEqual(resultC.partialValue, UInt4(6))
        XCTAssertEqual(resultC.overflow, false)
    }
    
    func testDividedReportingOverflow() {
        let resultA = UInt4(0).dividedReportingOverflow(by: UInt4(3))
        XCTAssertEqual(resultA.partialValue, UInt4(0))
        XCTAssertEqual(resultA.overflow, false)

        let resultB = UInt4(14).dividedReportingOverflow(by: UInt4(3))
        XCTAssertEqual(resultB.partialValue, UInt4(4))
        XCTAssertEqual(resultB.overflow, false)
        
        let resultC = UInt4(2).dividedReportingOverflow(by: UInt4(7))
        XCTAssertEqual(resultC.partialValue, UInt4(0))
        XCTAssertEqual(resultC.overflow, false)
        
        let resultD = UInt4(7).dividedReportingOverflow(by: UInt4(2))
        XCTAssertEqual(resultD.partialValue, UInt4(3))
        XCTAssertEqual(resultD.overflow, false)
        

        // NOTE: dividing by zero is not an error with this function
        //       - it will instead will report `overflow` as `true`
        //       and report the `partialValue` as the dividend
        //       (as per the function documentation)
        //       eg. `x.dividedReportingOverflow(by: 0)` is `(x, true)`
        //       HOWEVER - current implementations of UInt8, UInt16, etc
        //       cause a `Division by zero` error in Xcode.
        //       This appears to be a known bug in swift.
        //       See: https://bugs.swift.org/browse/SR-5964
        //       Our implementation will return the result as per
        //       the documentation (as there is no static Xcode
        //       checks for UInt4).
        let resultE = UInt4(2).dividedReportingOverflow(by: UInt4(0))
        XCTAssertEqual(resultE.partialValue, UInt4(2))
        XCTAssertEqual(resultE.overflow, true)
    }
    
    func testRemainderReportingOverflow() {
        let resultA = UInt4(0).remainderReportingOverflow(dividingBy: UInt4(3))
        XCTAssertEqual(resultA.partialValue, UInt4(0))
        XCTAssertEqual(resultA.overflow, false)
        
        let resultB = UInt4(14).remainderReportingOverflow(dividingBy: UInt4(3))
        XCTAssertEqual(resultB.partialValue, UInt4(2))
        XCTAssertEqual(resultB.overflow, false)

        let resultC = UInt4(2).remainderReportingOverflow(dividingBy: UInt4(7))
        XCTAssertEqual(resultC.partialValue, UInt4(2))
        XCTAssertEqual(resultC.overflow, false)

        let resultD = UInt4(7).remainderReportingOverflow(dividingBy: UInt4(2))
        XCTAssertEqual(resultD.partialValue, UInt4(1))
        XCTAssertEqual(resultD.overflow, false)

        // NOTE: dividing by zero is not an error with this function
        //       - it will instead will report `overflow` as `true`
        //       and report the `partialValue` as the dividend
        let resultE = UInt4(2).remainderReportingOverflow(dividingBy: UInt4(0))
        XCTAssertEqual(resultE.partialValue, UInt4(2))
        XCTAssertEqual(resultE.overflow, true)
    }
    
    func testMultipledFullWidth() {
        let result = UInt4(10).multipliedFullWidth(by: 10)
        let combinedResult = UInt8(result.high) << 4 | UInt8(result.low)
        XCTAssertEqual(combinedResult, 100)
    }
    
    func testDividingFullWidth() {
        // 100 as UInt8 = 0b0110_0100
        let result = UInt4(10).dividingFullWidth((high: UInt4(0b0110), low: UInt4(0b0100))) // = 100 / 10
        XCTAssertEqual(result.quotient, UInt4(10))
        XCTAssertEqual(result.remainder, UInt4(0))
        
        // 2 as UInt8 = 0b0000_0010
        let result2 = UInt4(10).dividingFullWidth((high: UInt4(0b0000), low: UInt4(0b0010)))  // = 2 / 10
        XCTAssertEqual(result2.quotient, UInt4(0))
        XCTAssertEqual(result2.remainder, UInt4(2))
    }
    
    func testNonZeroBitCount() {
        XCTAssertEqual(UInt4(0b0110).nonzeroBitCount, 2)
        XCTAssertEqual(UInt4(0b1101).nonzeroBitCount, 3)
        XCTAssertEqual(UInt4(0b0000).nonzeroBitCount, 0)
        XCTAssertEqual(UInt4(0b1000).nonzeroBitCount, 1)
        XCTAssertEqual(UInt4(0b0010).nonzeroBitCount, 1)
    }
    
    func testByteSwapped() {
        // four bits fits into 1 byte - thus no bytes to swap
        XCTAssertEqual(UInt4(15).byteSwapped, UInt4(15))
    }
    
    func testMax() {
        XCTAssertEqual(UInt4.max, 15)
    }
    
    func testMin() {
        XCTAssertEqual(UInt4.min, 0)
    }
}
