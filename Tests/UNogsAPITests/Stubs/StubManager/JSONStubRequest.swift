//
//  JSONStubRequest.swift
//  UNogsAPITests
//
//  Created by Brian Murphy on 14/02/2020.
//

import Foundation

struct JSONStubRequest {
    let host: String
    let path: String
    let queryParms: [String: String]

    init(host: String = "unogs-unogs-v1.p.rapidapi.com",
         path: String = "aaapi.cgi",
         queryParams: [String: String] = [:]) {
        self.host = host
        self.path = path
        self.queryParms = queryParams
    }
}
