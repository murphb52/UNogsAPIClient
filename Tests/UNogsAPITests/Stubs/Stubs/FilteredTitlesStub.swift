//
//  FilteredTitlesStub.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

internal struct FilteredTitlesStub: JSONStub {
    var request = JSONStubRequest(queryParams: ["q" : "-!1900,2018-!0,5-!0,10-!0-!Any-!Any-!Any-!gt1-!{downloadable}",
                                                "t": "ns",
                                                "cl": "all",
                                                "st": "adv",
                                                "ob": "Relevance",
                                                "p": "1",
                                                "sa": "an"])
    var response = JSONStubResponse(fileName: "filtered_titles.json")
}
