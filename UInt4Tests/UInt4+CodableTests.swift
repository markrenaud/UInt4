//
//    UInt4+Codable.swift
//    UInt4Tests
//
//    MIT License
//
//    Copyright (c) 2018 Jörg Polakowski
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
import Foundation
@testable import UInt4

final class UInt4_CodableTests: XCTestCase {

    private var encoder: JSONEncoder!
    private var decoder: JSONDecoder!

    override func setUp() {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }

    // MARK: encode(..)

    func test_encode() throws {
        // Given
        let systemUnderTest = UInt4(4)
        // When
        let data = try encoder.encode(systemUnderTest)
        // Then
        XCTAssertEqual(data, "4".data(using: .utf8))
    }

    func test_encode_embedded() throws {
        // Given
        let number = 3
        let codable = CodableTest(number: UInt4(number))
        // When
        let data = try encoder.encode(codable)
        // Then
        XCTAssertEqual(data, "{\"number\":\(number)}".data(using: .utf8)!)
    }

    // MARK: decode(..)

    func test_decode() throws {
        // Given
        let number = 9
        let data = fixtureData(number)
        // When
        let codable = try decoder.decode(CodableTest.self, from: data)
        // Then
        XCTAssertEqual(codable, CodableTest(number: UInt4(number)))
    }

    // MARK: Private

    func fixture(_ number: Int) -> String {
        """
        {
          "number": \(number)
        }
        """
    }

    func fixtureData(_ number: Int) -> Data {
        fixture(number).data(using: .utf8)!
    }
}

private struct CodableTest: Codable, Hashable {
    var number: UInt4
}
