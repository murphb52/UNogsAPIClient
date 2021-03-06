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
        XCTAssertEqual(FilteredTitlesQuery().queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
    }

    func testYears() {
        let year = Year(minimum: 2000, maximum: 2001)
        XCTAssertEqual(FilteredTitlesQuery(year: year).queryString, "-!2000,2001-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
    }

    func testNetflixRating() {
        let rating = NetflixRating(minimum: 2, maximum: 3)
        XCTAssertEqual(FilteredTitlesQuery(netflixRating: rating).queryString, "-!1990,2020-!2,3-!0,10-!-!Any-!Any-!Any-!gt1-!")
    }

    func testIMDBRating() {
        let rating = IMDBRating(minimum: 2, maximum: 3)
        XCTAssertEqual(FilteredTitlesQuery(imdbRating: rating).queryString, "-!1990,2020-!0,5-!2,3-!-!Any-!Any-!Any-!gt1-!")
    }

    func testAudio() {
        let items: [(languague: Language, value: String)] = [
            (.any, "Any"),
            (.arabic, "Arabic"),
            (.english, "English"),
            (.french, "French"),
            (.german, "German"),
            (.hindi, "Hindi"),
            (.italian, "Italian"),
            (.korean, "Korean"),
            (.mandarin, "Mandarin"),
            (.polish, "Polish"),
            (.portuguese, "Portuguese"),
            (.spanish, "Spanish"),
            (.turkish, "Turkish")
        ]

        for item in items {
            let string = FilteredTitlesQuery(audio: item.languague).queryString
            XCTAssertEqual(string, "-!1990,2020-!0,5-!0,10-!-!Any-!\(item.value)-!Any-!gt1-!")
        }
    }

    func testSubtitle() {
        let items: [(languague: Language, value: String)] = [
            (.any, "Any"),
            (.arabic, "Arabic"),
            (.english, "English"),
            (.french, "French"),
            (.german, "German"),
            (.hindi, "Hindi"),
            (.italian, "Italian"),
            (.korean, "Korean"),
            (.mandarin, "Mandarin"),
            (.polish, "Polish"),
            (.portuguese, "Portuguese"),
            (.spanish, "Spanish"),
            (.turkish, "Turkish")
        ]

        for item in items {
            let string = FilteredTitlesQuery(subtitle: item.languague).queryString
            XCTAssertEqual(string, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!\(item.value)-!gt1-!")
        }
    }

    func testVideoType() {
        XCTAssertEqual(FilteredTitlesQuery(videoType: .any).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
        XCTAssertEqual(FilteredTitlesQuery(videoType: .movie).queryString, "-!1990,2020-!0,5-!0,10-!-!Movie-!Any-!Any-!gt1-!")
        XCTAssertEqual(FilteredTitlesQuery(videoType: .series).queryString, "-!1990,2020-!0,5-!0,10-!-!Series-!Any-!Any-!gt1-!")
    }

    func testGenres() {
        XCTAssertEqual(FilteredTitlesQuery(genreIdentifiers: []).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
        XCTAssertEqual(FilteredTitlesQuery(genreIdentifiers: [1,2,3]).queryString, "-!1990,2020-!0,5-!0,10-!1,2,3-!Any-!Any-!Any-!gt1-!")
    }

    func testMinimumIMDBVotes() {
        XCTAssertEqual(FilteredTitlesQuery(minimumIMDBVotes: .init(votesRequired: 1)).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
        XCTAssertEqual(FilteredTitlesQuery(minimumIMDBVotes: .init(votesRequired: 99)).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt99-!")
    }

    func testDownloadable() {
        XCTAssertEqual(FilteredTitlesQuery(downloadable: .empty).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!")
        XCTAssertEqual(FilteredTitlesQuery(downloadable: .yes).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!Yes")
        XCTAssertEqual(FilteredTitlesQuery(downloadable: .no).queryString, "-!1990,2020-!0,5-!0,10-!-!Any-!Any-!Any-!gt1-!No")

    }

    func testSort() {
        XCTAssertEqual(FilteredTitlesQuery(sort: .date).sort.rawValue, "Date")
        XCTAssertEqual(FilteredTitlesQuery(sort: .filmYear).sort.rawValue, "FilmYear")
        XCTAssertEqual(FilteredTitlesQuery(sort: .rating).sort.rawValue, "Rating")
        XCTAssertEqual(FilteredTitlesQuery(sort: .relevance).sort.rawValue, "Relevance")
        XCTAssertEqual(FilteredTitlesQuery(sort: .runtime).sort.rawValue, "Runtime")
        XCTAssertEqual(FilteredTitlesQuery(sort: .title).sort.rawValue, "Title")
        XCTAssertEqual(FilteredTitlesQuery(sort: .videoType).sort.rawValue, "VideoType")
        XCTAssertEqual(FilteredTitlesQuery(sort: .default).sort.rawValue, "Rating")
    }

    func testCountriesList() {
        XCTAssertEqual(FilteredTitlesQuery().countriesFilter.stringValue, "all")
        XCTAssertEqual(FilteredTitlesQuery(countriesFilter: .all).countriesFilter.stringValue, "all")
        XCTAssertEqual(FilteredTitlesQuery(countriesFilter: .list(countryIds: ["1", "2"])).countriesFilter.stringValue, "1,2")
    }

}
