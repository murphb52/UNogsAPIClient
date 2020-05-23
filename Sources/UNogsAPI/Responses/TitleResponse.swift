//
//  TitleResponse.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation
import Combine

public struct TitleResponse: Codable, Equatable, Identifiable {
    public typealias TitleIdentifier = String

    public var id: TitleIdentifier
    public let title: String
    public let image: String
    public let synopsis: String
    public let rating: String
    public let type: TitleType
    public let released: String
    public let runtime: String
    public let unogsdate: String
    public let imdbId: String

    public init(id: String,
                title: String,
                image: String,
                synopsis: String,
                rating: String,
                type: TitleType,
                released: String,
                runtime: String,
                unogsdate: String,
                imdbId: String) {
        self.id = id
        self.title = title
        self.image = image
        self.synopsis = synopsis
        self.rating = rating
        self.type = type
        self.released = released
        self.runtime = runtime
        self.unogsdate = unogsdate
        self.imdbId = imdbId
    }

    enum CodingKeys: String, CodingKey {
        case id = "netflixid"
        case title
        case image
        case synopsis
        case rating
        case type
        case released
        case runtime
        case unogsdate
        case imdbId = "imdbid"
    }
}
