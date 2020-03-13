//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum Downloadable: String, QueryComponent, Defaultable {
    public static var `default`: Downloadable = .empty

    case empty = ""
    case yes = "Yes"
    case no = "No"
}
