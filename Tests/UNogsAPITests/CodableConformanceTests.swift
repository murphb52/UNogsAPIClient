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

final class CodableConformanceTests: XCTestCase {

    func testCodableConformance() throws {
        let jsonString = "{\"COUNT\": \"1\", \"ITEMS\": [[\"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\", \"1\",]]}"
        let data = jsonString.data(using: .utf8)
        let country = try JSONDecoder().decode(ItemsResponse<Country>.self, from: data!)

        assertCodableConformance(of: country)
    }

}


private extension CodableConformanceTests {

    typealias EquatableCodable = Codable&Equatable

    func assertCodableConformance<T: EquatableCodable>(of object: T) {
        guard let encoded = try? JSONEncoder().encode(object) else {
            XCTFail("Unable to encode")
            return
        }
        let decoded = try? JSONDecoder().decode(T.self, from: encoded)
        XCTAssertNotNil(decoded)
        XCTAssertEqual(object, decoded)
    }

}
