//
//    UInt4+BinaryInteger.swift
//    UInt4
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

import Foundation

extension UInt4: BinaryInteger {
    
    public typealias Words = [UInt]
    
    public init<T>(_ source: T) where T : BinaryInteger {
        defer {
            // use defer so that willSet bounds checking on internalValue will get called from the init
            internalValue = Int(source)
        }
    }
    
    public init<T>(_ source: T) where T : BinaryFloatingPoint {
        defer {
            // use defer so that willSet bounds checking on internalValue will get called from the init
            internalValue = Int(source)
        }
    }
    
    // while a default implementation is provided, as of Swift 4.1
    public init<T>(clamping source: T) where T : BinaryInteger {
        if source > UInt4.max.internalValue {
            internalValue = UInt4.max.internalValue
        } else if source < UInt4.min.internalValue {
            internalValue = UInt4.min.internalValue
            return
        } else {
            internalValue = Int(source)
        }
    }
    
    
    public var  bitWidth: Int {
        return 4
    }
    
    public var trailingZeroBitCount: Int {
        if internalValue.trailingZeroBitCount > 4 {
            return 4
        }
        return internalValue.trailingZeroBitCount
    }
    
    public var words: UInt4.Words {
        return [UInt(internalValue)]
    }
    
    public static var isSigned: Bool {
        return false
    }
    
    public static func % (lhs: UInt4, rhs: UInt4) -> UInt4 {
        return UInt4(lhs.internalValue % rhs.internalValue)
    }
    
    public static func %= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue %= rhs.internalValue
    }
    
    public static func &= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue &= rhs.internalValue
    }
    
    
    public static func / (lhs: UInt4, rhs: UInt4) -> UInt4 {
        return UInt4(lhs.internalValue / rhs.internalValue)
    }
    
    public static func /= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue /= rhs.internalValue
    }
    
    public static func ^= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue ^= rhs.internalValue
    }
    
    public static func |= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue |= rhs.internalValue
    }
    
    // MARK: - Replacing missing or buggy default implementations
    
    // Note: while bit shift default implementations
    //       should be added by default, it seems
    //       there is a current error
    //       bitshift operators needed to be added
    //       added manually to avoid error: "Inlining
    //      'transparent' functions forms circular
    //       loop"
    // See:  https://github.com/apple/swift/pull/14761
    //       https://bugs.swift.org/browse/SR-7019?attachmentViewMode=list
    
    public static func >> (lhs: UInt4, rhs: Int) -> UInt4 {
        // a -'ve >> is really a <<
        if rhs < 0 {
            return lhs << abs(rhs)
        }
        return UInt4(lhs.internalValue >> rhs)
    }
    
    public static func << (lhs: UInt4, rhs: Int) -> UInt4 {
        // a -'ve << is really a >>
        if rhs < 0 {
            return lhs >> abs(rhs)
        }
        let uValue = UInt8(lhs.internalValue) << rhs
        let bitWidthDiff = uValue.bitWidth - 4
        let newUValue = (uValue << bitWidthDiff) >> bitWidthDiff
        return UInt4(newUValue)
    }
    
    public static func >>= (lhs: inout UInt4, rhs: Int) {
        let result = lhs >> rhs
        lhs.internalValue = result.internalValue
    }

    public static func <<= (lhs: inout UInt4, rhs: Int) {
        let result = lhs << rhs
        lhs.internalValue = result.internalValue
    }

    
}
