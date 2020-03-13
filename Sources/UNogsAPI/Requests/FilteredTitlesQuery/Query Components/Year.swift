//
//  Year.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public struct Year: QueryComponent, Defaultable {
    public static let `default` = Year(minimum: 1990, maximum: 2020)

    let minimum: Int
    let maximum: Int

    public init(minimum: Int, maximum: Int) {
        self.minimum = minimum
        self.maximum = maximum
    }

    var stringValue: String { "\(minimum),\(maximum)" }
}
