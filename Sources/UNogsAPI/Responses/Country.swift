//
//  Country.swift
//  UNogsAPI
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct Country: Codable {
    public enum InformationIndex: Int {
        case shortCode = 1
        case name = 2
        case priceType = 9
    }

    let values: [String]
    let name: String
    let shortCode: String
    let priceType: String

    init(values: [String]) {
        self.values = values
        self.name = values[.name]
        self.shortCode = values[.shortCode]
        self.priceType = values[.priceType]
    }
}

private extension Array where Element == String {
    subscript(_ index: Country.InformationIndex) -> String {
        return self[index.rawValue]
    }
}

extension Country: CustomDebugStringConvertible {
    public var debugDescription: String { "\(shortCode), \(values.count): \(name)" }
}
