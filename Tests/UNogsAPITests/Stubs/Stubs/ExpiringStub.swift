//
//  ExpiringStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

internal struct ExpiringStub: JSONStub {
    var request = JSONStubRequest(queryParams: ["p": "1",
                                                "q" : "get:exp:GB",
                                                "t": "ns",
                                                "st": "adv"])
    var response = JSONStubResponse(fileName: "expiring.json")
}
