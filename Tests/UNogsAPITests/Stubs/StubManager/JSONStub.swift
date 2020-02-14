//
//  JSONStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

protocol JSONStub {
    var request: JSONStubRequest { get }
    var response: JSONStubResponse { get }
}
