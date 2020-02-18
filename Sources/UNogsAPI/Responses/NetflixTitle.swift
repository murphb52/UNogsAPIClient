//
//  NetflixTitle.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation
import Combine

public struct NetflixTitle: Codable, Equatable, Identifiable {
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

    public var id: String { return netflixid }
    public let netflixid: String
    public let title: String
    public let image: String
    public let synopsis: String
    public let rating: String
    public let type: TitleType
    public let released: String
    public let runtime: String
    public let unogsdate: String
}
