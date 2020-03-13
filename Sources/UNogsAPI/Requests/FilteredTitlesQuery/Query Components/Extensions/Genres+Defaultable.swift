//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

extension Array: Defaultable where Element == Genre {
    public static var `default`: [Genre] = []
}
