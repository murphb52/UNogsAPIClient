//
//  File.swift
//  
//
//  Created by Brian Murphy on 24/03/2020.
//

import Foundation

public enum TitleType : String, Codable {
    case series
    case movie

    public init(from decoder: Decoder) throws {
        // The API is unreliable and have seen instances of Movies and movie being returned so we must massage the data
        let container = try decoder.singleValueContainer()
        let string = try decoder.singleValueContainer().decode(String.self)
        let lowerCasedString = string.lowercased()
        guard let type = TitleType(rawValue: lowerCasedString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown TitleType: \(string)")
        }
        self = type
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
