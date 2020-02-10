import Foundation
import Combine

public class UNogsAPIClient {

    private lazy var headers = [
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
        "x-rapidapi-key": apiKey
    ]

    private let baseURLString = "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi"
    private let apiKey: String

    public init (apiKey: String) {
        self.apiKey = apiKey
    }

    public func countriesPublisher() -> AnyPublisher<ItemsResponse<Country>, Error> {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "t", value: "lc"),
            URLQueryItem(name: "q", value: "available"),
        ]))
    }

    public func newReleasesPublisher() -> AnyPublisher<ItemsResponse<NetflixTitle>, Error>  {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "p", value: "1"),
            URLQueryItem(name: "q", value: "get:new7:GB"),
            URLQueryItem(name: "t", value: "ns"),
            URLQueryItem(name: "st", value: "adv"),
        ]))
    }

    public func expiringPublisher() -> AnyPublisher<ItemsResponse<NetflixTitle>, Error>  {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "p", value: "1"),
            URLQueryItem(name: "q", value: "get:exp:GB"),
            URLQueryItem(name: "t", value: "ns"),
            URLQueryItem(name: "st", value: "adv"),
        ]))
    }

    public func filteredTitlesPublisher() -> AnyPublisher<ItemsResponse<NetflixTitle>, Error> {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "q", value: "-!1900,2018-!0,5-!0,10-!0-!Any-!Any-!Any-!gt1-!{downloadable}"),
            URLQueryItem(name: "t", value: "ns"),
            URLQueryItem(name: "cl", value: "all"),
            URLQueryItem(name: "st", value: "adv"),
            URLQueryItem(name: "ob", value: "Relevance"),
            URLQueryItem(name: "p", value: "1"),
            URLQueryItem(name: "sa", value: "an"),
        ]))
    }

}

private extension UNogsAPIClient {

    func createGetRequest(queryItems: [URLQueryItem] = []) -> URLRequest {
        var urlComponenets = URLComponents()
        urlComponenets.scheme = "https"
        urlComponenets.host = "unogs-unogs-v1.p.rapidapi.com"
        urlComponenets.path = "/aaapi.cgi"
        urlComponenets.queryItems = queryItems

        let request = NSMutableURLRequest(url: urlComponenets.url!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }

    func publisher<T: Codable>(for request: URLRequest) -> AnyPublisher<T, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }

}
