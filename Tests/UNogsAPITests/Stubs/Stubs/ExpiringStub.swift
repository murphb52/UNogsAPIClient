//
//  ExpiringStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

internal struct ExpiringStub: JSONStub {
    var request: JSONStubRequest
    var response = JSONStubResponse(fileName: "expiring.json")

    init(_ countryShortCode: String) {
        self.request = JSONStubRequest(queryParams: [
            "p": "1",
            "q" : "get:exp:\(countryShortCode)",
            "t": "ns",
            "st": "adv"]
        )
    }
}
