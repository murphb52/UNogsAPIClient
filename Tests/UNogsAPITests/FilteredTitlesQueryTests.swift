//
//  FilteredTitlesQueryTests.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import XCTest
@testable import UNogsAPI

class FilteredTitlesQueryTests: XCTestCase {

    func testDefaultInit() {
        XCTAssertEqual(FilteredTitlesQuery().queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
    }

    func testYears() {
        let year = FilteredTitlesQuery.Year(minimum: 2000, maximum: 2001)
        XCTAssertEqual(FilteredTitlesQuery(year: year).queryString, "-!2000,2001-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
    }

    func testNetflixRating() {
        let rating = FilteredTitlesQuery.NetflixRating(minimum: 2, maximum: 3)
        XCTAssertEqual(FilteredTitlesQuery(netflixRating: rating).queryString, "-!1990,2020-!2,3-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
    }

    func testIMDBRating() {
        let rating = FilteredTitlesQuery.IMDBRating(minimum: 2, maximum: 3)
        XCTAssertEqual(FilteredTitlesQuery(imdbRating: rating).queryString, "-!1990,2020-!0,5-!2,3-!-!Any-!Any-!Any-!gt1-!{downloadable}")
    }

    func testAudio() {
        XCTAssertEqual(FilteredTitlesQuery(audio: .any).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(audio: .english).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!English-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(audio: .chinese).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Chinese-!Any-!gt1-!{downloadable}")
    }

    func testSubtitle() {
        XCTAssertEqual(FilteredTitlesQuery(subtitle: .any).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(subtitle: .english).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!English-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(subtitle: .chinese).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Chinese-!gt1-!{downloadable}")
    }

    func testVideoType() {
        XCTAssertEqual(FilteredTitlesQuery(videoType: .any).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(videoType: .movie).queryString, "-!1990,2020-!0,5-!0,10-!-!Movie-!Any-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(videoType: .series).queryString, "-!1990,2020-!0,5-!0,10-!-!Series-!Any-!Any-!gt1-!{downloadable}")
    }

    func testGenres() {
        let genre = Genre(name: "Action", identifiers: [1,2,3])
        XCTAssertEqual(FilteredTitlesQuery(genres: []).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!{downloadable}")
        XCTAssertEqual(FilteredTitlesQuery(genres: [genre]).queryString, "-!1990,2020-!0,5-!0,10-!1,2,3-!Any-!Any-!Any-!gt1-!{downloadable}")
    }

}
