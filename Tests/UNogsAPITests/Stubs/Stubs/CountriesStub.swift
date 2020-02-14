//
//  CountriesStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

public struct CountriesStub: JSONStub {
    var request = JSONStubRequest(queryParams: ["t": "lc",
                                               "q": "available"])
    var response = JSONStubResponse(fileName: "countries.json")
}
