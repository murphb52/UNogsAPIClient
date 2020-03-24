//
//  File.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation

extension RawRepresentable where RawValue == String {
    var stringValue: String { rawValue }
}
