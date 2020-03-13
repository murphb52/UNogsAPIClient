//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

protocol Defaultable {
    associatedtype Value

    static var `default`: Value { get }
}
