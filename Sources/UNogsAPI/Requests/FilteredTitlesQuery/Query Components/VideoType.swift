//
//  VideoType.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum VideoType: String, QueryComponent, Defaultable {
    public static var `default`: VideoType = .any

    case any = "Any"
    case movie = "Movie"
    case series = "Series"
}
