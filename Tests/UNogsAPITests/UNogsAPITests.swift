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
            XCTAssertEqual(response.count, "34")
            XCTAssertEqual(response.objects.count, 34)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.shortCode)
        }
    }

    func testNewReleases() {
        JSONStubManager.setupStub(.newReleases)

        assert(publisher: sut.newReleasesPublisher()) { response in
            XCTAssertEqual(response.count, "36")
            XCTAssertEqual(response.objects.count, 36)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testExpiring() {
        JSONStubManager.setupStub(.expiring)

        assert(publisher: sut.expiringPublisher()) { response in
            XCTAssertEqual(response.count, "70")
            XCTAssertEqual(response.objects.count, 70)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWithBlankQuery() {
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
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWith7DaysNewQuery() {
        let query = FilteredTitlesQuery(queryType: .getNew(days: 7),
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
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }
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

