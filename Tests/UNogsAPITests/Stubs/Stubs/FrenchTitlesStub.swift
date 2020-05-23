//
//  File.swift
//  
//
//  Created by Brian Murphy on 23/05/2020.
//

import Foundation

internal struct FrenchTitlesStub: JSONStub {
    var request: JSONStubRequest = JSONStubRequest(queryParams: [
        "p":    "1",
        "q":    "-!1990,2020-!0,5-!0,10-!-!Any-!French-!Any-!gt1-!",
        "t":    "ns",
        "st":   "adv",
        "cl":   "all",
        "ob":   "Rating",
        "sa":   "and"
        ]
    )
    var response = JSONStubResponse(fileName: "french_titles.json")
}
