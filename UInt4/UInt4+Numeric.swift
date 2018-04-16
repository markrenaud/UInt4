//
//    UInt4+Numeric.swift
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

extension UInt4: Numeric {
    
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let intVal = Int(exactly: source) else { return nil }
        if (intVal < 16) && (intVal >= 0) {
            internalValue = intVal
        } else {
            return nil
        }
    }

    public static func -= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue -= rhs.internalValue
    }
    
    public static func - (lhs: UInt4, rhs: UInt4) -> UInt4 {
        return UInt4(lhs.internalValue - rhs.internalValue)
    }
    
    public static func += (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue += rhs.internalValue
    }
    
    public static func + (lhs: UInt4, rhs: UInt4) -> UInt4 {
        return UInt4(lhs.internalValue + rhs.internalValue)
    }
    
    public static func * (lhs: UInt4, rhs: UInt4) -> UInt4 {
        return UInt4(lhs.internalValue * rhs.internalValue)
    }
    
    public static func *= (lhs: inout UInt4, rhs: UInt4) {
        lhs.internalValue *= rhs.internalValue
    }
    
    public typealias Magnitude = UInt4
    
    public var magnitude: UInt4 {
        return self
    }
    
}
