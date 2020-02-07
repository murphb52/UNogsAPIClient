//
//  File.swift
//  
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct CountriesResponse: Codable {
    public let count: String
    public let countries: [Country]

    enum CodingKeys: String, CodingKey {
        case count = "COUNT"
        case items = "ITEMS"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(String.self, forKey: .count)

        let items = try values.decode([[String]].self, forKey: .items)
        countries = items.compactMap(Country.init)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(countries.map({ $0.values }), forKey: .items)
    }
}
