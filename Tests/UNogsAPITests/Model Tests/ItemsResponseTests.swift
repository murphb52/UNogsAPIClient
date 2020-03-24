//
//  ItemsResponseTests.swift
//  
//
//  Created by Brian Murphy on 20/02/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

final class ItemsResponseTests: CodableConformanceTest {

    func testPublicInit() throws {
        let item = ItemsResponse(count: "10", objects: [
            TitleResponse(netflixid: "netflixid",
                         title: "title",
                         image: "image",
                         synopsis: "synopsis",
                         rating: "rating",
                         type: .movie,
                         released: "released",
                         runtime: "runtime",
                         unogsdate: "unogsdate")
        ])
        XCTAssertNotNil(item)
        XCTAssertEqual(item.objects.first?.netflixid, "netflixid")
        XCTAssertEqual(item.objects.first?.title, "title")
        XCTAssertEqual(item.objects.first?.image, "image")
        XCTAssertEqual(item.objects.first?.synopsis, "synopsis")
        XCTAssertEqual(item.objects.first?.rating, "rating")
        XCTAssertEqual(item.objects.first?.type, .movie)
        XCTAssertEqual(item.objects.first?.released, "released")
        XCTAssertEqual(item.objects.first?.runtime, "runtime")
        XCTAssertEqual(item.objects.first?.unogsdate, "unogsdate")
    }

}
