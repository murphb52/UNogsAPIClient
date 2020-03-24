//
//  GenresResponse.swift
//  OHHTTPStubs
//
//  Created by Brian Murphy on 09/03/2020.
//

import Foundation

public struct GenreResponse: Codable, Equatable {
    public typealias GenreIdentifier = Int

    public enum DecodingError: Error {
        case noData
    }

    public let name: String
    public let identifiers: [GenreIdentifier]

    public init(name: String, identifiers: [GenreIdentifier]) {
        self.name = name
        self.identifiers = identifiers
    }

    internal struct GenreCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) { self.stringValue = stringValue }
        init?(intValue: Int) { return nil }
        init(key: String) { self.stringValue = key }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKey.self)
        guard let key = container.allKeys.first else {
            throw GenreResponse.DecodingError.noData
        }
        name = key.stringValue
        identifiers = try container.decode([Int].self, forKey: key)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenreCodingKey.self)
        try container.encode(identifiers, forKey: GenreCodingKey(key: name))
    }
}
