//
//  File.swift
//  
//
//  Created by Brian Murphy on 18/02/2020.
//

import Foundation

public struct FilteredTitlesQuery {
    public enum QueryType {
        private enum Constants {
            static let getNewKey = "get:new"
        }

        case getNew(days: Int)
        case blank

        public var stringValue: String {
            switch self {
            case .blank: return ""
            case .getNew(let days): return Constants.getNewKey + "\(days)"
            }
        }
    }
    public struct Year {
        let minimum: Int
        let maximum: Int

        public init(minimum: Int = 1900,
                    maximum: Int = 2020) {
            self.minimum = minimum
            self.maximum = maximum
        }

        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public struct NetflixRating {
        let minimum: Int
        let maximum: Int

        public init(minimum: Int = 0,
                    maximum: Int = 5) {
            self.minimum = minimum
            self.maximum = maximum
        }

        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public struct IMDBRating {
        let minimum: Int
        let maximum: Int

        public init(minimum: Int = 0,
                    maximum: Int = 10) {
            self.minimum = minimum
            self.maximum = maximum
        }

        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public enum Sort: String {
        case relevance = "Relevance"
        case date = "Date"
        case rating = "Rating"
        case title = "Title"
        case videoType = "VideoType"
        case filmYear = "FilmYear"
        case runtime = "Runtime"
    }

    public enum Audio: String {
        case any = "Any"
        case english = "English"
        case chinese = "Chinese"
    }

    public enum Subtitle: String {
        case any = "Any"
        case english = "English"
        case chinese = "Chinese"
    }

    public enum VideoType: String {
        case any = "Any"
        case movie = "Movie"
        case series = "Series"
    }

    let queryType: QueryType
    let year: Year
    let netflixRating: NetflixRating
    let imdbRating: IMDBRating
    let sort: Sort
    let subtitle: Subtitle
    let audio: Audio
    let videoType: VideoType
    let genreID: Int

    public init(queryType: QueryType,
                year: Year,
                netflixRating: NetflixRating,
                imdbRating: IMDBRating,
                sort: Sort,
                subtitle: Subtitle,
                audio: Audio,
                videoType: VideoType,
                genreID: Int) {
        self.queryType = queryType
        self.year = year
        self.netflixRating = netflixRating
        self.imdbRating = imdbRating
        self.sort = sort
        self.subtitle = subtitle
        self.audio = audio
        self.videoType = videoType
        self.genreID = genreID
    }

    public var queryString: String {
        let value = [
            queryType.stringValue,
            year.stringValue,
            netflixRating.stringValue,
            imdbRating.stringValue,
            "\(genreID)",
            videoType.rawValue,
            audio.rawValue,
            subtitle.rawValue,
            "gt1",
            "{downloadable}"
        ].joined(separator: "-!")
        return value
    }
}
