//
//  File.swift
//  
//
//  Created by Brian Murphy on 09/03/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

final class GenreTests: CodableConformanceTest {

    func testPublicInit() throws {
        let genre = Genre(name: "Example", identifiers: [1,2,3])
        XCTAssertNotNil(genre)
    }

    func testInitializingCodingKeyWithIntValueReturnsNil() {
        XCTAssertNil(Genre.GenreCodingKey(intValue: 0))
    }

    func testCodableConformance() throws {
        let data = try JSONFileReader.shared.jsonData(from: "genres_response.json")
        let genreResponse = try JSONDecoder().decode(ItemsResponse<Genre>.self, from: data)
        try assertCodableConformance(of: genreResponse)
    }

    func testDecodingFailsIfNoKeysArePresent() throws {
        do {
            let data = try JSONFileReader.shared.jsonData(from: "empty_genre_response.json")
            _ = try JSONDecoder().decode(Genre.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is Genre.DecodingError)
        }
    }

}
