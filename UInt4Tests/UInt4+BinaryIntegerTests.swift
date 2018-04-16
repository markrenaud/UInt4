//
//    UInt4+BinaryIntegerTests.swift
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

class UInt4_BinaryIntegerTests: XCTestCase {
    
    func testBaseInit() {
        XCTAssertEqual(UInt4(), 0)
    }
    
    func testInitFromFloatingPoint() {
        // should round down
        XCTAssertEqual(UInt4(5.4), 5)
        XCTAssertEqual(UInt4(0.3), 0)
    }
    
    func testInitFromInteger() {
        XCTAssertEqual(UInt4(5), 5)
        XCTAssertEqual(UInt4(0), 0)
        XCTAssertEqual(UInt4(15), 15)
    }
    
    func testInitClamping() {
        XCTAssertEqual(UInt4(clamping: -1), 0)
        XCTAssertEqual(UInt4(clamping: 16), 15)
        XCTAssertEqual(UInt4(clamping: 0), 0)
        XCTAssertEqual(UInt4(clamping: 15), 15)
        XCTAssertEqual(UInt4(clamping: Int.max), 15)
        XCTAssertEqual(UInt4(clamping: Int.min), 0)
    }
    
    func testInitExactly() {
        XCTAssertNotNil(UInt4(exactly: 15))
        XCTAssertNotNil(UInt4(exactly: 0))
        XCTAssertNil(UInt4(exactly: 16))
        XCTAssertNil(UInt4(exactly: -1))
    }
    
    func testInitTruncatingIfNeeded() {
        let y = UInt4(truncatingIfNeeded: 0b10010110)
        XCTAssertEqual(y, 0b0110)
    }
    
    func testBitWidth() {
        XCTAssertEqual(UInt4().bitWidth, 4)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(UInt4(0b1000).trailingZeroBitCount, 3)
        XCTAssertEqual(UInt4(0b0000).trailingZeroBitCount, 4)
        XCTAssertEqual(UInt4(0b1100).trailingZeroBitCount, 2)
        XCTAssertEqual(UInt4(0b0110).trailingZeroBitCount, 1)
    }
    
    func testWords() {
        let x = UInt4(15)
        XCTAssertEqual(x.words.count, 1)
        XCTAssertEqual(x.words.first, 15)
    }
    
    func testIsSigned() {
        XCTAssertFalse(UInt4.isSigned)
    }
    
    func testQuotientAndRemainderDividingBy() {
        let x = UInt4(15)
        let xqr = x.quotientAndRemainder(dividingBy: 4)
        XCTAssertEqual(xqr.quotient, 3)
        XCTAssertEqual(xqr.remainder, 3)
        
        let y = UInt4(2)
        let yqr = y.quotientAndRemainder(dividingBy: 15)
        XCTAssertEqual(yqr.quotient, 0)
        XCTAssertEqual(yqr.remainder, 2)
    }
    
    func testSignum() {
        XCTAssertEqual(UInt4(0).signum(), 0)
        XCTAssertEqual(UInt4(4).signum(), 1)
    }
    
    func testModulo() {
        let x = UInt4(5)
        let y = UInt4(2)
        XCTAssertEqual(x % y, 1)
    }
    
    func testModuloInOut() {
        var x = UInt4(5)
        let y = UInt4(2)
        
        x %= y
        
        XCTAssertEqual(x, 1)
    }
    
    func testBitwiseAND() {
        let a = UInt4(0b0101)
        let b = UInt4(0b1101)
        
        XCTAssertEqual(a & b, 0b0101)
    }
    
    func testBitwiseAndInOut() {
        var a = UInt4(0b1101)
        let b = UInt4(0b1001)
        
        a &= b
        
        XCTAssertEqual(a, 0b1001)
    }
    
    func testMultiplication() {
        let a = UInt4(3)
        let b = UInt4(5)
        
        XCTAssertEqual(a * b, 15)
    }

    func testMultiplicationInOut() {
        var a = UInt4(4)
        let b = UInt4(0)
        
        a *= b
        
        XCTAssertEqual(a, 0)
    }
    
    func testSubtraction() {
        let a = UInt4(5)
        let b = UInt4(2)
        
        XCTAssertEqual(a - b, 3)
    }
    
    func testSubtractionInOut() {
        var a = UInt4(15)
        let b = UInt4(6)
        
        a -= b
        
        XCTAssertEqual(a, 9)
    }

    func testDivision() {
        let a = UInt4(7)
        let b = UInt4(2)
        
        XCTAssertEqual(a / b, 3)

    }
    
    func testDivisionInOut() {
        var a = UInt4(8)
        let b = UInt4(6)
        
        a /= b
        
        XCTAssertEqual(a, 1)
    }
    
    func testBitwiseXOR() {
        let a = UInt4(0b0101)
        let b = UInt4(0b1101)
        
        XCTAssertEqual(a ^ b, 0b1000)
        
        let c = UInt4(0b1111)
        let d = UInt4(0b0100)
        
        XCTAssertEqual(c ^ d, 0b1011)
    }
    
    func testBitwiseXORInOut() {
        var a = UInt4(0b0101)
        a ^= UInt4(0b1101)
        
        XCTAssertEqual(a, 0b1000)
        
        var c = UInt4(0b1111)
        c ^= UInt4(0b0100)
        
        XCTAssertEqual(c, 0b1011)
    }
    
    func testBitwiseOR() {
        let a = UInt4(0b0101)
        let b = UInt4(0b1101)
        
        XCTAssertEqual(a | b, 0b1101)
        
        let c = UInt4(0b1111)
        let d = UInt4(0b0100)
        
        XCTAssertEqual(c | d, 0b1111)
    }
    
    func testBitwiseORInOut() {
        var a = UInt4(0b0101)
        a |= UInt4(0b1101)
        
        XCTAssertEqual(a, 0b1101)
        
        var c = UInt4(0b1111)
        c |= UInt4(0b0100)
        
        XCTAssertEqual(c, 0b1111)
    }

    // MARK: - Testing replaced (missing or buggy) default implementations
    
    // Note: while bit shift default implementations
    //       should be added by default, it seems
    //       there is a current error
    //       bitshift operators needed to be added
    //       added manually to avoid error: "Inlining
    //      'transparent' functions forms circular
    //       loop"
    // See:  https://github.com/apple/swift/pull/14761
    //       https://bugs.swift.org/browse/SR-7019?attachmentViewMode=list
    
    func testBitShiftRight() {
        let a = UInt4(0b0110)
        XCTAssertEqual(a >>  2, 0b0001)
        XCTAssertEqual(a >> -1, 0b1100)
        
        let b = UInt4(0b1111)
        XCTAssertEqual(b >>  3, 0b0001)
        XCTAssertEqual(b >> -3, 0b1000)

    }
    
    func testBitShiftLeft() {
        let a = UInt4(0b0110)
        XCTAssertEqual(a << -2, 0b0001)
        XCTAssertEqual(a <<  1, 0b1100)
        
        let b = UInt4(0b1111)
        XCTAssertEqual(b << -3, 0b0001)
        XCTAssertEqual(b <<  3, 0b1000)
        
    }
    
    func testBitShiftRightInOut() {
        var a1 = UInt4(0b0110)
        a1 >>= 2
        XCTAssertEqual(a1, 0b0001)
        
        var a2 = UInt4(0b0110)
        a2 >>= -1
        XCTAssertEqual(a2, 0b1100)
        
        var b1 = UInt4(0b1111)
        b1 >>= 3
        XCTAssertEqual(b1, 0b0001)
        
        var b2 = UInt4(0b1111)
        b2 >>= -3
        XCTAssertEqual(b2, 0b1000)
        
    }

    func testBitShiftLeftInOut() {
        var a1 = UInt4(0b0110)
        a1 <<= -2
        XCTAssertEqual(a1, 0b0001)
        
        var a2 = UInt4(0b0110)
        a2 <<= 1
        XCTAssertEqual(a2, 0b1100)
        
        var b1 = UInt4(0b1111)
        b1 <<= -3
        XCTAssertEqual(b1, 0b0001)
        
        var b2 = UInt4(0b1111)
        b2 <<= 3
        XCTAssertEqual(b2, 0b1000)

    }
    
}
