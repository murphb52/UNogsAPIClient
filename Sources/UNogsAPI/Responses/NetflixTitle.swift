//
//  NetflixTitle.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct NetflixTitle: Codable, Equatable {
    enum TitleType : String, Codable {
        case series
        case movie
    }

    let title: String
    let image: String
    let synopsis: String
    let rating: String
    let type: TitleType
    let released: String
    let runtime: String
    let unogsdate: String
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
}

extension NetflixTitle: CustomDebugStringConvertible {
    public var debugDescription: String { "\(type), \(unogsdate), \(rating): \(title)" }
}
