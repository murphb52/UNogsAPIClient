//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

extension Array: Defaultable where Element == GenreResponse {
    public static var `default`: [GenreResponse] = []
}
