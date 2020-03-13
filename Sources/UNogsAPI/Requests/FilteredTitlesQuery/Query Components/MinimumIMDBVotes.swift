//
//  MinimumIMDBVotes.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

public struct MinimumIMDBVotes: QueryComponent, Defaultable {
    public static let `default` = MinimumIMDBVotes(votesRequired: 1)

    let votesRequired: Int

    public init(votesRequired: Int) {
        self.votesRequired = votesRequired
    }
    
    var stringValue: String { "gt\(votesRequired)" }
}
