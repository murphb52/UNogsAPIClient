//
//  UNogsAPIClient+Country.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation
import Combine

public extension UNogsAPIClient {

    func countriesPublisher() -> AnyPublisher<ItemsResponse<Country>, Error> {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "t", value: "lc"),
            URLQueryItem(name: "q", value: "available"),
        ]))
    }

}
