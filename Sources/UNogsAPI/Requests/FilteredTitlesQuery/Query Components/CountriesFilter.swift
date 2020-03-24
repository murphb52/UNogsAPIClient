//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum CountriesFilter: QueryComponent, Defaultable {
    public static var `default` = CountriesFilter.all

    case all
    case list(countryIds: [CountryResponse.CountryIdentifier])

    var stringValue: String {
        switch self {
        case .all:
            return "all"
        case .list(let identifiers):
            return identifiers.joined(separator: ",")
        }
    }
}
