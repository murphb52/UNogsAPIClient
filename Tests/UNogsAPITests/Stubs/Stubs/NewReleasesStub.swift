//
//  NewReleasesStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

internal struct NewReleasesStub: JSONStub {
    var request = JSONStubRequest(queryParams: ["p": "1",
                                                "q": "get:new7:GB",
                                                "t": "ns",
                                                "st": "adv"])
    var response = JSONStubResponse(fileName: "new_releases.json")
}
