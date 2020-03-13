//
//  QueryType.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum QueryType: QueryComponent, Defaultable {
    public static var `default`: QueryType = .blank

    private enum Constants {
        static let getNewKey = "get:new"
    }

    case getNew(days: Int)
    case blank

    var stringValue: String {
        switch self {
        case .blank: return ""
        case .getNew(let days): return Constants.getNewKey + "\(days)"
        }
    }
}
