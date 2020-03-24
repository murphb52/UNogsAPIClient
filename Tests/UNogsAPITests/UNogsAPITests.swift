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

            XCTAssertEqual(response.objects.first?.id, response.objects.first?.id)
            XCTAssertEqual(response.objects.first?.id, "21")
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
        try JSONStubManager.setupStub(.newReleases(countryShortCode: "GB"))

        assert(publisher: sut.newReleasesPublisher(countryShortCode: "GB")) { response in
            XCTAssertEqual(response.count, "36")
            XCTAssertEqual(response.objects.count, 36)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testExpiring() throws {
        try JSONStubManager.setupStub(.expiring(countryShortCode: "US"))

        assert(publisher: sut.expiringPublisher(countryShortCode: "US")) { response in
            XCTAssertEqual(response.count, "70")
            XCTAssertEqual(response.objects.count, 70)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWithBlankQuery() throws {
        let query = FilteredTitlesQuery()
        try JSONStubManager.setupStub(.filteredTitles(query: query))
        
        assert(publisher: sut.filteredTitlesPublisher(query: query)) { response in
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testFilteredTitlesWith7DaysNewQuery() throws {
        let genre = GenreResponse(name: "Action", identifiers: [1,2,3])
        let query = FilteredTitlesQuery(queryType: .getNew(days: 7),
                                        genres: [genre])

        try JSONStubManager.setupStub(.filteredTitles(query: query))

        assert(publisher: sut.filteredTitlesPublisher(query: query)) { response in
            XCTAssertEqual(response.count, "11118")
            XCTAssertEqual(response.objects.count, 100)
            XCTAssertEqual(response.objects.first?.id, response.objects.first?.netflixid)
        }
    }

    func testGenres() throws {
        try JSONStubManager.setupStub(.genres)
        
        assert(publisher: sut.genresPublisher()) { response in
            XCTAssertEqual(response.count, "517")
            XCTAssertEqual(response.objects.count, 517)
            XCTAssertEqual(response.objects.first?.name, "All Action")
            XCTAssertEqual(response.objects.first?.identifiers.count, 21)
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

