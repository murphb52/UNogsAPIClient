//
//  File.swift
//  
//
//  Created by Brian Murphy on 07/02/2020.
//

import Foundation

public struct ItemsResponse<T: Codable & Equatable>: Codable, Equatable {
    public let count: String
    public let objects: [T]

    enum CodingKeys: String, CodingKey {
        case count = "COUNT"
        case objects = "ITEMS"
    }
}


