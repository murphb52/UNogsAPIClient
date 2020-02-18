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

    func testDecodingNetflixTitleWithIncorrectTitleType() throws {
        let fileURL = JSONFileReader.shared.jsonFile(named: "netflix_title_incorrect_title_type.json")!
        let data = try Data(contentsOf: fileURL)
        do {
            _ = try JSONDecoder().decode(NetflixTitle.self, from: data)
            XCTFail()
        } catch {
            guard let decodingError = error as? DecodingError else {
                XCTFail("Unexpected Failure")
                return
            }
            switch decodingError {
            case .dataCorrupted(let context):
                XCTAssertEqual(context.debugDescription, "Unknown TitleType: something wrong")
            default: XCTFail("Unexpected Failure")
            }
        }
    }

    func testCodableConformanceOfNetflixTitle() throws {
        let title = NetflixTitle(netflixid: "123",
                                 title: "Movie Title!",
                                 image: "...",
                                 synopsis: "...",
                                 rating: "5",
                                 type: .movie,
                                 released: "Yesterday",
                                 runtime: "123mins",
                                 unogsdate: "2019-09")
        let encoded = try JSONEncoder().encode(title)
        let decoded = try JSONDecoder().decode(NetflixTitle.self, from: encoded)
        XCTAssertEqual(title, decoded)
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
