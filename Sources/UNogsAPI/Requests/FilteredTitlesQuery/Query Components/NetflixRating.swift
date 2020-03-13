//
//  NetflixRating.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public struct NetflixRating: QueryComponent, Defaultable {
    public static let `default` = NetflixRating(minimum: 0, maximum: 5)
    
    let minimum: Int
    let maximum: Int

    public init(minimum: Int, maximum: Int) {
        self.minimum = minimum
        self.maximum = maximum
    }

    var stringValue: String { "\(minimum),\(maximum)" }
}
