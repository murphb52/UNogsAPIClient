//
//  Country.swift
//  UNogsAPI
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct Country: Codable, Equatable, Identifiable {
    public typealias CountryIdentifier = String

    public enum InformationIndex: Int, CaseIterable {
        case id = 0
        case shortCode
        case name
        case newTitles
        case unknownProperty
        case expiringTitles
        case totalTitles
        case totalSeries
        case totalMovies
        case currency
        case priceTier1
        case priceTier2
        case priceTier3
    }

    public let id: CountryIdentifier
    public let values: [String]
    public let shortCode: String
    public let name: String
    public let newTitles: Int
    public let expiringTitles: Int
    public let totalTitles: Int
    public let totalSeries: Int
    public let totalMovies: Int
    public let currency: String
    public let priceTier1: String
    public let priceTier2: String
    public let priceTier3: String

    public init(values: [String],
                id: String,
                shortCode: String,
                name: String,
                newTitles: Int,
                expiringTitles: Int,
                totalTitles: Int,
                totalSeries: Int,
                totalMovies: Int,
                currency: String,
                priceTier1: String,
                priceTier2: String,
                priceTier3: String) {
        self.values = values
        self.id = id
        self.shortCode = shortCode
        self.name = name
        self.newTitles = newTitles
        self.expiringTitles = expiringTitles
        self.totalTitles = totalTitles
        self.totalSeries = totalSeries
        self.totalMovies = totalMovies
        self.currency = currency
        self.priceTier1 = priceTier1
        self.priceTier2 = priceTier2
        self.priceTier3 = priceTier3
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        values = try container.decode([String].self)
        guard values.count == InformationIndex.allCases.count else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unexpected number of values")
        }
        id = values[.id]
        shortCode = values[.shortCode]
        name = values[.name]
        newTitles = try values[.newTitles].toInt()
        expiringTitles = try values[.expiringTitles].toInt()
        totalTitles = try values[.totalTitles].toInt()
        totalSeries = try values[.totalSeries].toInt()
        totalMovies = try values[.totalMovies].toInt()
        currency = values[.currency]
        priceTier1 = values[.priceTier1]
        priceTier2 = values[.priceTier1]
        priceTier3 = values[.priceTier3]
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}

private extension Array where Element == String {
    subscript(_ index: Country.InformationIndex) -> String {
        return self[index.rawValue]
    }
}

internal extension String {

    enum ParsingError: Error {
        case stringIsNotAnInt
    }

    func toInt() throws -> Int {
        guard let intValue = Int(self) else {
            throw ParsingError.stringIsNotAnInt
        }
        return intValue
    }

}
