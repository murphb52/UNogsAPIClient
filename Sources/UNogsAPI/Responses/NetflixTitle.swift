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
    /*
     "title":"Heidi"
     "image":"http://art-1.nflximg.net/de202/fd3380ee585b86954bd7ed91dd331f1d02dde202.jpg"
     "synopsis":"Orphaned at age 5, curly-haired Heidi is sent to live with her gruff recluse of a grandfather in the Swiss Alps and soon thaws his frozen heart.<br><b>New on 2017-08-05</b>"
     "rating":"0"
     "type":"movie"
     "released":"2015"
     "runtime":"1h50m"
     "largeimage":""
     "unogsdate":"2017-08-05"
     "imdbid":"tt3700392"
     "download":"0"
     */

    public init(netflixid: String,
                title: String,
                image: String,
                synopsis: String,
                rating: String,
                type: TitleType,
                released: String,
                runtime: String,
                unogsdate: String) {
        self.netflixid = netflixid
        self.title = title
        self.image = image
        self.synopsis = synopsis
        self.rating = rating
        self.type = type
        self.released = released
        self.runtime = runtime
        self.unogsdate = unogsdate
    }
}

extension NetflixTitle: CustomDebugStringConvertible {
    public var debugDescription: String { "\(type), \(unogsdate), \(rating): \(title)" }
}
