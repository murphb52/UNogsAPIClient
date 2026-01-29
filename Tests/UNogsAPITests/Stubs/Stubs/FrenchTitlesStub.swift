//
//  File.swift
//  
//
//  Created by Brian Murphy on 23/05/2020.
//

import Foundation
@testable import UNogsAPI

internal struct FrenchTitlesStub: JSONStub {
    var request: JSONStubRequest
    var response = JSONStubResponse(fileName: "french_titles.json")

    init() {
        let query = FilteredTitlesQuery(audio: .french, subtitlesAudioAndOr: .and)
        self.request = JSONStubRequest(queryParams: [
            "p":  "1",
            "q":  query.queryString,
            "t":  "ns",
            "st": "adv",
            "cl": "all",
            "ob": query.sort.rawValue,
            "sa": "and"
        ])
    }
}
