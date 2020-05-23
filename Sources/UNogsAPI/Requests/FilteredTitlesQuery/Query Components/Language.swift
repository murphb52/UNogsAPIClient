//
//  File.swift
//  
//
//  Created by Brian Murphy on 14/05/2020.
//

import Foundation

public enum Language: String, QueryComponent, Defaultable {
    public static var `default`: Language = .any

    case any = "Any"
    case arabic = "Arabic"
    case english = "English"
    case french = "French"
    case german = "German"
    case hindi = "Hindi"
    case italian = "Italian"
    case korean = "Korean"
    case mandarin = "Mandarin"
    case polish = "Polish"
    case portuguese = "Portuguese"
    case spanish = "Spanish"
    case turkish = "Turkish"
}
