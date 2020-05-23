//
//  File.swift
//  
//
//  Created by Brian Murphy on 22/05/2020.
//

import Foundation

public enum AndOr: String, Defaultable {
    public static var `default`: AndOr = .and

    case and
    case or
}
