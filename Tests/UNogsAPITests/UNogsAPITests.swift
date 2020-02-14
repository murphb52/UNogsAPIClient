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
        JSONStubManager.setupStub(.filteredTitles)

        assert(publisher: sut.filteredTitlesPublisher()) { response in
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

