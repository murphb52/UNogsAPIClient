//
//  FilteredTitlesStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation
@testable import UNogsAPI

internal struct FilteredTitlesStub: JSONStub {
    var request: JSONStubRequest
    var response = JSONStubResponse(fileName: "filtered_titles.json")

    init(query: FilteredTitlesQuery) {
        self.request = JSONStubRequest(queryParams:
            ["q" : query.queryString,
             "t": "ns",
             "cl": "all",
             "st": "adv",
             "ob": query.sort.rawValue,
             "p": "1",
             "sa": "and"]
        )
    }
}
