//
//    UInt4+FixedWidthInteger.swift
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
extension UInt4: FixedWidthInteger {
    
    public static var bitWidth: Int {
        return 4
    }
    
    public func addingReportingOverflow(_ rhs: UInt4) -> (partialValue: UInt4, overflow: Bool) {
        let value = self.internalValue + rhs.internalValue
        let max = Int(UInt4.max)
        if value > max {
            return (UInt4(value - max - 1), true)
        }
        return (UInt4(value), false)
    }
    
    public func subtractingReportingOverflow(_ rhs: UInt4) -> (partialValue: UInt4, overflow: Bool) {
        let value = self.internalValue - rhs.internalValue
        let max = Int(UInt4.max)
        if value < 0 {
            return (UInt4(max + value + 1), true)
        }
        return (UInt4(value), false)
    }
    
    public func multipliedReportingOverflow(by rhs: UInt4) -> (partialValue: UInt4, overflow: Bool) {
        let value = self.internalValue * rhs.internalValue
        let max = Int(UInt4.max)
        if value > max{
            return (UInt4(value - max - 1), true)
        }
        return (UInt4(value), false)
        
    }
    
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
    public func dividedReportingOverflow(by rhs: UInt4) -> (partialValue: UInt4, overflow: Bool) {
        if rhs.internalValue == 0 {
            return (self, true)
        }
        return (UInt4(self.internalValue / rhs.internalValue), false)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: UInt4) -> (partialValue: UInt4, overflow: Bool) {
        if rhs.internalValue == 0 {
            return (self, true)
        }
        let remainder = self.internalValue % rhs.internalValue
        return (UInt4(remainder), false)
    }
    
    public func multipliedFullWidth(by other: UInt4) -> (high: UInt4, low: UInt4) {
        let result = UInt8(self.internalValue * other.internalValue)
        let low = UInt4((result << 4) >> 4)
        let high = UInt4(result >> 4)
        return (high, low)
    }
    
    public func dividingFullWidth(_ dividend: (high: UInt4, low: UInt4)) -> (quotient: UInt4, remainder: UInt4) {
        
        if self == 0 {
            fatalError("Division by zero")
        }
        let combined: UInt8 = (UInt8(dividend.high) << 4) | UInt8(dividend.low)
        
        let quotient8 = combined / UInt8(self)
        let remainder8 = combined % UInt8(self)
        // if the quotient is GREATER than the max value of the
        // return type - then we will do as standard library does
        // and truncate rather than crash
        // see: https://github.com/apple/swift/blob/d5c904b4f7faa0dea2ea4a0d8c17a1ec2fb0e0b1/stdlib/public/core/Integers.swift.gyb#L3596
        let quotient4 = UInt4((quotient8 << 4) >> 4)
        // the remainder should fit into the return type
        let remainder4 = UInt4(remainder8)
        
        return (quotient4, remainder4)
    }
    
    public var nonzeroBitCount: Int {
        return internalValue.nonzeroBitCount
    }
    
    public var leadingZeroBitCount: Int {
        // convert to UInt8 first (to handle possiblity
        // of < 64-bit systerms), then get rid of additional leading
        // 4-bits worth of zeros
        return internalValue.leadingZeroBitCount - 4
    }
    
    public var byteSwapped: UInt4 {
        // as UInt4 is less than 8 bits, it is less than 1 byte
        // thus there is only 1 byte, and it cannot be swapped
        return self
    }
    
    public static var max: UInt4 {
        return UInt4(15)
    }
    
    public static var min: UInt4 {
        return UInt4(0)
    }
    
    // MARK: - Replacing missing or buggy default implementations
    
    // we shouldn't need to generate this init - but we do
    // and hopefully we shouldn't need by Swift 5.0
    // see: https://forums.swift.org/t/how-do-i-make-a-uint0/9516/3
    // Essentially this function chops off leading bits
    // if it can't fit into the number of bits provided by UInt4
    // see: https://github.com/apple/swift/blob/d5c904b4f7faa0dea2ea4a0d8c17a1ec2fb0e0b1/stdlib/public/core/Integers.swift.gyb#L3499
    public init<T>(_truncatingBits source: T) where T : BinaryInteger {
        // convert to Int
        let value = Int(source)
        // truncate by off all but trailing 4 bits of data
        internalValue = (value << (value.bitWidth - 4)) >> (value.bitWidth - 4)
    }

    
}
