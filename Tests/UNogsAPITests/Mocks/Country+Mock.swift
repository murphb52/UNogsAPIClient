//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation
import UNogsAPI

extension CountryResponse {
    static func mock(values: [String] = [],
                     id: String = UUID().uuidString,
                     shortCode: String = UUID().uuidString,
                     name: String = UUID().uuidString,
                     newTitles: Int = 1,
                     expiringTitles: Int = 2,
                     totalTitles: Int = 2,
                     totalSeries: Int = 1,
                     totalMovies: Int = 1,
                     currency: String = "GBP",
                     priceTier1: String = "1.99",
                     priceTier2: String = "2.99",
                     priceTier3: String = "3.99") -> CountryResponse {
        CountryResponse(values: values,
                id: id,
                shortCode: shortCode,
                name: name,
                newTitles: newTitles,
                expiringTitles: expiringTitles,
                totalTitles: totalTitles,
                totalSeries: totalSeries,
                totalMovies: totalMovies,
                currency: currency,
                priceTier1: priceTier1,
                priceTier2: priceTier2,
                priceTier3: priceTier3)
    }

    static let gb = CountryResponse.mock(shortCode: "GB")
    static let us = CountryResponse.mock(shortCode: "US")
}
