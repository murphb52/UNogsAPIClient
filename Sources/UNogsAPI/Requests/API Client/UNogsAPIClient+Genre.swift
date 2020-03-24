//
//  UNogsAPIClient+Genre.swift
//  
//
//  Created by Brian Murphy on 13/03/2020.
//

import Foundation
import Combine

public extension UNogsAPIClient {

    func genresPublisher() -> AnyPublisher<ItemsResponse<GenreResponse>, Error> {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "t", value: "genres")
        ]))
    }

}
