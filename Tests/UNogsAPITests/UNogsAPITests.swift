import XCTest
import Foundation
@testable import UNogsAPI
import Combine

final class UNogsAPITests: XCTestCase {

    let sut = UNogsAPIClient(apiKey: "dummy_key")
    var disposabes: [AnyCancellable] = []

    override func tearDown() {
        disposabes.removeAll()

        JSONStubManager.tearDown()
    }

    func testCountries() throws {
        try JSONStubManager.setupStub(.countries)

        assert(publisher: sut.countriesPublisher()) { response in
            XCTAssertEqual(response.count, "34")
            XCTAssertEqual(response.objects.count, 34)

            XCTAssertEqual(response.objects.first?.id, response.objects.first?.identifier)
            XCTAssertEqual(response.objects.first?.identifier, "21")
            XCTAssertEqual(response.objects.first?.shortCode, "ar")
            XCTAssertEqual(response.objects.first?.name, "Argentina ")
            XCTAssertEqual(response.objects.first?.newTitles, 15)
            XCTAssertEqual(response.objects.first?.expiringTitles, 53)
            XCTAssertEqual(response.objects.first?.totalTitles, 4514)
            XCTAssertEqual(response.objects.first?.totalSeries, 1531)
            XCTAssertEqual(response.objects.first?.totalMovies, 2983)
            XCTAssertEqual(response.objects.first?.currency, "ARS")
            XCTAssertEqual(response.objects.first?.priceTier1, "109")
            XCTAssertEqual(response.objects.first?.priceTier2, "109")
            XCTAssertEqual(response.objects.first?.priceTier3, "189")
        }
    }

    func testNewReleases() throws {
        try JSONStubManager.setupStub(.newReleases)

        assert(publisher: sut.newReleasesPublisher()) { response in
            XCTAssertEqual(response.count, "36")
            XCTAssertEqual(response.objects.count, 36)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testExpiring() throws {
        try JSONStubManager.setupStub(.expiring)

        assert(publisher: sut.expiringPublisher()) { response in
            XCTAssertEqual(response.count, "70")
            XCTAssertEqual(response.objects.count, 70)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWithBlankQuery() throws {
        let query = FilteredTitlesQuery(queryType: .blank,
                                        year: .standard,
                                        netflixRating: .standard,
                                        imdbRating: .standard,
                                        sort: .rating,
                                        subtitle: .any,
                                        audio: .any,
                                        videoType: .any,
                                        genreID: 0)

        try JSONStubManager.setupStub(.filteredTitles(query: query))
        
        assert(publisher: sut.filteredTitlesPublisher(query: query)) { response in
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWith7DaysNewQuery() throws {
        let query = FilteredTitlesQuery(queryType: .getNew(days: 7),
                                        year: .standard,
                                        netflixRating: .standard,
                                        imdbRating: .standard,
                                        sort: .rating,
                                        subtitle: .any,
                                        audio: .any,
                                        videoType: .any,
                                        genreID: 0)

        try JSONStubManager.setupStub(.filteredTitles(query: query))

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

