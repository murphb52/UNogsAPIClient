//
//  Sort.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum Sort: String, QueryComponent, Defaultable {
    public static var `default`: Sort = .rating

    case relevance = "Relevance"
    case date = "Date"
    case rating = "Rating"
    case title = "Title"
    case videoType = "VideoType"
    case filmYear = "FilmYear"
    case runtime = "Runtime"
}
