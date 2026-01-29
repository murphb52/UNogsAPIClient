//
//  Year.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public struct Year: QueryComponent, Defaultable {
    private static var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }

    public static var `default`: Year {
        Year(minimum: 1990, maximum: currentYear)
    }

    let minimum: Int
    let maximum: Int

    public init(minimum: Int, maximum: Int) {
        self.minimum = minimum
        self.maximum = maximum
    }

    var stringValue: String { "\(minimum),\(maximum)" }
}
