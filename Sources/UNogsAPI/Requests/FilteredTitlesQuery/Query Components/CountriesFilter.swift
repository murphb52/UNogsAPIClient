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
    case list(countries: [Country])

    var stringValue: String {
        switch self {
        case .all:
            return "all"
        case .list(let countries):
            return countries.map { $0.identifier }.joined(separator: ",")
        }
    }
}
