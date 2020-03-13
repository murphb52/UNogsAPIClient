import Foundation
import Combine

public class UNogsAPIClient {
    private lazy var headers = [
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
        "x-rapidapi-key": apiKey
    ]

    private let baseURLString = "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi"
    private let apiKey: String
    public var timeout: TimeInterval = 10.0
    public var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    public var decoder = JSONDecoder()

    public init (apiKey: String) {
        self.apiKey = apiKey
    }
}

internal extension UNogsAPIClient {

    func createGetRequest(queryItems: [URLQueryItem] = []) -> URLRequest {
        var urlComponenets = URLComponents()
        urlComponenets.scheme = "https"
        urlComponenets.host = "unogs-unogs-v1.p.rapidapi.com"
        urlComponenets.path = "/aaapi.cgi"
        urlComponenets.queryItems = queryItems

        let request = NSMutableURLRequest(url: urlComponenets.url!,
                                          cachePolicy: cachePolicy,
                                          timeoutInterval: timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }

    func publisher<T: Codable>(for request: URLRequest) -> AnyPublisher<T, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
        return publisher
    }

}
