import XCTest
import Foundation
@testable import UNogsAPI
import Combine

final class UNogsAPITests: XCTestCase {

    let sut = UNogsAPIClient()
    var disposabes: [AnyCancellable] = []

    override func tearDown() {
        disposabes.removeAll()

        JSONStubManager.tearDown()
    }

    func testCountries() {
        JSONStubManager.setupStub(.countries)

        assert(publisher: sut.countriesPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "34")
            XCTAssertEqual(response.objects.count, 34)
        }
    }

    func testNewReleases() {
        JSONStubManager.setupStub(.newReleases)

        assert(publisher: sut.newReleasesPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "36")
            XCTAssertEqual(response.objects.count, 36)
        }
    }

    func testExpiring() {
        JSONStubManager.setupStub(.expiring)

        assert(publisher: sut.expiringPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "70")
            XCTAssertEqual(response.objects.count, 70)
        }
    }

    func testFilteredTitles() {
        let query = FilteredTitlesQuery(queryType: .blank,
                                        year: .standard,
                                        netflixRating: .standard,
                                        imdbRating: .standard,
                                        sort: .rating,
                                        subtitle: .any,
                                        audio: .any,
                                        videoType: .any,
                                        genreID: 0)

        JSONStubManager.setupStub(.filteredTitles(query: query))
        
        assert(publisher: sut.filteredTitlesPublisher(query: query)) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
        }
    }

    static var allTests = [
        ("testCountries", testCountries),
        ("testNewReleases", testNewReleases),
        ("testExpiring", testExpiring),
        ("testFilteredTitles", testFilteredTitles),
    ]
}

private extension UNogsAPITests {

    func assert<T>(publisher: AnyPublisher<ItemsResponse<T>, Error>,
                   receiveClosure: @escaping (_ response: ItemsResponse<T>) -> Void) {
        let testExpectation = expectation(description: #function)

        publisher
            .sink(receiveCompletion: { (completion) in
                XCTAssertNil(completion.error)
                testExpectation.fulfill()
            },
                  receiveValue: { (response) in
                    receiveClosure(response)
            })
            .store(in: &disposabes)

        waitForExpectations(timeout: 5, handler: nil)
    }

}

extension Subscribers.Completion {
    var error: Error? {
        switch self {
        case .failure(let error): return error
        case .finished: return nil
        }
    }
}

