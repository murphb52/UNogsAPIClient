//
//  Country.swift
//  UNogsAPI
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct Country: Codable, Equatable, Identifiable {
    public enum InformationIndex: Int {
        case shortCode = 1
        case name = 2
        case priceType = 9
    }

    public var id: String { return shortCode }
    let values: [String]
    public let name: String
    public let shortCode: String
    public let priceType: String

    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        values = try value.decode([String].self)
        name = values[.name]
        shortCode = values[.shortCode]
        priceType = values[.priceType]
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
