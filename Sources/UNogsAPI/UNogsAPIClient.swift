import Foundation
import Combine

public class UNogsAPIClient {

    private let apiKey: String

    public init (apiKey: String) {
        self.apiKey = apiKey
    }

    public func fetchCountries() -> AnyPublisher<ItemsResponse<Country>, Error> {
        let headers = [
            "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
            "x-rapidapi-key": apiKey
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?t=lc&q=available")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let publisher = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .map { $0.data }
            .decode(type: ItemsResponse<Country>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }

    public func fetchNewReleases() -> AnyPublisher<ItemsResponse<NetflixTitle>, Error>  {
        let headers = [
            "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
            "x-rapidapi-key": "78baf00b28mshbf956afb933554bp178222jsn8a38b0e16183"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew7%3AGB&p=1&t=ns&st=adv")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let publisher = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .map { $0.data }
            .decode(type: ItemsResponse<NetflixTitle>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }

}
