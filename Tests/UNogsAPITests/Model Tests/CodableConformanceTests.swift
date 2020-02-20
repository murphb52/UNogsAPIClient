//
//  CodableConformanceTests.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 07/02/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

class CodableConformanceTest: XCTestCase {

    typealias EquatableCodable = Codable & Equatable

    func assertCodableConformance<T: EquatableCodable>(of object: T) throws {
        let encoded = try JSONEncoder().encode(object)
        let decoded = try JSONDecoder().decode(T.self, from: encoded)
        XCTAssertNotNil(decoded)
        XCTAssertEqual(object, decoded)
    }

}
