//
//  CountryCodableTests.swift
//  
//
//  Created by Brian Murphy on 19/02/2020.
//

import XCTest
import Foundation
import Combine
@testable import UNogsAPI

final class CountryCodableTests: CodableConformanceTest {

    func testCodableConformance() throws {
        let data = try JSONFileReader.shared.jsonData(from: "countries.json")
        let countryResponse = try JSONDecoder().decode(ItemsResponse<Country>.self, from: data)
        try assertCodableConformance(of: countryResponse)
    }

    func testDecodingFailsIfIncorrectNumberOfProperties() throws {
        do {
            let data = try JSONFileReader.shared.jsonData(from: "countries_incorrect_elements.json")
            _ = try JSONDecoder().decode(Country.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testDecodingFailsIfIntPropertiesCannotBeParsed() throws {
        do {
            let data = try JSONFileReader.shared.jsonData(from: "countries_unable_to_parse_ints.json")
            _ = try JSONDecoder().decode(Country.self, from: data)
            XCTFail()
        } catch {
            XCTAssertTrue(error is String.ParsingError)
        }
    }

}
