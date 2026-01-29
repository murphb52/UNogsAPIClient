//
//  UNogsAPIClient+Async.swift
//
//  Async/await convenience APIs mirroring the existing Combine publisher-based methods.
//

import Foundation

public extension UNogsAPIClient {

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func countries() async throws -> ItemsResponse<CountryResponse> {
        try await request(for: createGetRequest(queryItems: [
            URLQueryItem(name: "t", value: "lc"),
            URLQueryItem(name: "q", value: "available"),
        ]))
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func genres() async throws -> ItemsResponse<GenreResponse> {
        try await request(for: createGetRequest(queryItems: [
            URLQueryItem(name: "t", value: "genres")
        ]))
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func newReleases(countryShortCode: String) async throws -> ItemsResponse<TitleResponse> {
        try await request(for: createGetRequest(queryItems: [
            URLQueryItem(name: "p",  value: "1"),
            URLQueryItem(name: "q",  value: "get:new7:\(countryShortCode)"),
            URLQueryItem(name: "t",  value: "ns"),
            URLQueryItem(name: "st", value: "adv"),
        ]))
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func expiring(countryShortCode: String) async throws -> ItemsResponse<TitleResponse> {
        try await request(for: createGetRequest(queryItems: [
            URLQueryItem(name: "p",  value: "1"),
            URLQueryItem(name: "q",  value: "get:exp:\(countryShortCode)"),
            URLQueryItem(name: "t",  value: "ns"),
            URLQueryItem(name: "st", value: "adv"),
        ]))
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func filteredTitles(query: FilteredTitlesQuery) async throws -> ItemsResponse<TitleResponse> {
        try await request(for: createGetRequest(queryItems: [
            URLQueryItem(name: "q",  value: query.queryString),
            URLQueryItem(name: "t",  value: "ns"),
            URLQueryItem(name: "cl", value: query.countriesFilter.stringValue),
            URLQueryItem(name: "st", value: "adv"),
            URLQueryItem(name: "ob", value: query.sort.rawValue),
            URLQueryItem(name: "p",  value: "1"),
            URLQueryItem(name: "sa", value: query.subtitlesAudioAndOr.rawValue),
        ]))
    }
}

internal extension UNogsAPIClient {

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func request<T: Decodable>(for request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(T.self, from: data)
    }
}
