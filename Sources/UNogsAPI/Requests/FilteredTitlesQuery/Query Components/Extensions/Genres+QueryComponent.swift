//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

extension Array: QueryComponent where Element == GenreResponse.GenreIdentifier {
    var stringValue: String {
        self.map { "\($0)" }
            .joined(separator: ",")
    }
}
