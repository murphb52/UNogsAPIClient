//
//  CountryTests.swift
//  
//
//  Created by Brian Murphy on 19/02/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

final class CountryTests: CodableConformanceTest {

    func testPublicInit() throws {
        let country = CountryResponse(values: [],
                              id: "identifier",
                              shortCode: "shortCode",
                              name: "name",
                              newTitles: 0,
                              expiringTitles: 1,
                              totalTitles: 2,
                              totalSeries: 3,
                              totalMovies: 4,
                              currency: "currency",
                              priceTier1: "priceTier1",
                              priceTier2: "priceTier2",
                              priceTier3: "priceTier3")
        XCTAssertNotNil(country)
        XCTAssertEqual(country.values, [])
        XCTAssertEqual(country.id, "identifier")
        XCTAssertEqual(country.shortCode, "shortCode")
        XCTAssertEqual(country.name, "name")
        XCTAssertEqual(country.newTitles, 0)
        XCTAssertEqual(country.expiringTitles, 1)
        XCTAssertEqual(country.totalTitles, 2)
        XCTAssertEqual(country.totalSeries, 3)
        XCTAssertEqual(country.totalMovies, 4)
        XCTAssertEqual(country.currency, "currency")
        XCTAssertEqual(country.priceTier1, "priceTier1")
        XCTAssertEqual(country.priceTier2, "priceTier2")
        XCTAssertEqual(country.priceTier3, "priceTier3")
    }

    func testCodableConformance() throws {
        let data = try JSONFileReader.shared.jsonData(from: "countries.json")
        let countryResponse = try JSONDecoder().decode(ItemsResponse<CountryResponse>.self, from: data)
        try assertCodableConformance(of: countryResponse)
    }

    func testDecodingFailsIfIncorrectNumberOfProperties() throws {
        do {
            let data = try JSONFileReader.shared.jsonData(from: "countries_incorrect_elements.json")
            _ = try JSONDecoder().decode(CountryResponse.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testDecodingFailsIfIntPropertiesCannotBeParsed() throws {
        do {
            let data = try JSONFileReader.shared.jsonData(from: "countries_unable_to_parse_ints.json")
            _ = try JSONDecoder().decode(CountryResponse.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is String.ParsingError)
        }
    }

}
