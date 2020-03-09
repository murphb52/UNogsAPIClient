//
//  File.swift
//  
//
//  Created by Brian Murphy on 09/03/2020.
//

import Foundation
@testable import UNogsAPI

internal struct GenresStub: JSONStub {
    var request = JSONStubRequest(queryParams: ["t": "genres"])
    var response = JSONStubResponse(fileName: "genres_response.json")
}
