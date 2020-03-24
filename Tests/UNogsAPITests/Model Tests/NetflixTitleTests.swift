//
//  NetflixTitleTests.swift
//  
//
//  Created by Brian Murphy on 19/02/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

final class NetflixTitleTests: CodableConformanceTest {

    func testCodableConformanceOfNetflixTitle() throws {
        let title = TitleResponse(netflixid: "123",
                                 title: "Movie Title!",
                                 image: "...",
                                 synopsis: "...",
                                 rating: "5",
                                 type: .movie,
                                 released: "Yesterday",
                                 runtime: "123mins",
                                 unogsdate: "2019-09")
        try assertCodableConformance(of: title)
    }

    func testDecodingNetflixTitleWithIncorrectTitleType() throws {
        let fileURL = try JSONFileReader.shared.jsonFile(named: "netflix_title_incorrect_title_type.json")
        let data = try Data(contentsOf: fileURL)
        do {
            _ = try JSONDecoder().decode(TitleResponse.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

}
