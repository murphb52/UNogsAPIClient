//
//  Audio.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum Audio: String, QueryComponent, Defaultable {
    public static var `default`: Audio = .any

    case any = "Any"
    case english = "English"
    case chinese = "Chinese"
}
