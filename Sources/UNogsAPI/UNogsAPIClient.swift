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

    public func filteredTitlesPublisher(query: FilteredTitlesQuery) -> AnyPublisher<ItemsResponse<NetflixTitle>, Error> {
        return publisher(for: createGetRequest(queryItems: [
            URLQueryItem(name: "q", value: query.queryString),
            URLQueryItem(name: "t", value: "ns"),
            URLQueryItem(name: "cl", value: "all"),
            URLQueryItem(name: "st", value: "adv"),
            URLQueryItem(name: "ob", value: query.sort.rawValue),
            URLQueryItem(name: "p", value: "1"),
            URLQueryItem(name: "sa", value: "an"),
        ]))
    }

}

public struct FilteredTitlesQuery {
    public enum QueryType: RawRepresentable {
        private enum Constants {
            static let getNewKey = "get:new"
        }

        case getNew(days: Int)
        case blank

        public init?(rawValue: String) {
            switch rawValue {
            case "":
                self = .blank
            case let rawValue where rawValue.hasPrefix(Constants.getNewKey):
                guard let int = Int(rawValue.deletingPrefix(Constants.getNewKey)) else {
                    return nil
                }
                self = .getNew(days: int)
            default:
                return nil
            }
        }

        public var rawValue: String {
            switch self {
            case .blank: return ""
            case .getNew(let days): return Constants.getNewKey + "\(days)"
            }
        }
    }
    public struct Year {
        let minimum: Int
        let maximum: Int

        public static let standard = Year(minimum: 1900, maximum: 2020)
        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public struct NetflixRating {
        let minimum: Int
        let maximum: Int

        public static let standard = NetflixRating(minimum: 0, maximum: 5)
        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public struct IMDBRating {
        let minimum: Int
        let maximum: Int

        public static let standard = IMDBRating(minimum: 0, maximum: 10)
        public var stringValue: String { "\(minimum),\(maximum)" }
    }

    public enum Sort: String {
        case relevance = "Relevance"
        case date = "Date"
        case rating = "Rating"
        case title = "Title"
        case videoType = "VideoType"
        case filmYear = "FilmYear"
        case runtime = "Runtime"
    }

    public enum Audio: String {
        case any = "Any"
        case english = "English"
        case chinese = "Chinese"
    }

    public enum Subtitle: String {
        case any = "Any"
        case english = "English"
        case chinese = "Chinese"
    }

    public enum VideoType: String {
        case any = "Any"
        case movie = "Movie"
        case series = "Series"
    }

    let queryType: QueryType
    let year: Year
    let netflixRating: NetflixRating
    let imdbRating: IMDBRating
    let sort: Sort
    let subtitle: Subtitle
    let audio: Audio
    let videoType: VideoType
    let genreID: Int

    public var queryString: String {
        let value = [
            queryType.rawValue,
            year.stringValue,
            netflixRating.stringValue,
            imdbRating.stringValue,
            "\(genreID)",
            videoType.rawValue,
            audio.rawValue,
            subtitle.rawValue,
            "gt1",
            "{downloadable}"
        ].joined(separator: "-!")
        return value
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

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
