//
//  Subtitle.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public enum Subtitle: String, QueryComponent, Defaultable {
    public static var `default`: Subtitle = .any

    case any = "Any"
    case english = "English"
    case chinese = "Chinese"
}
