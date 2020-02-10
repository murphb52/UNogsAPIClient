import XCTest
import Foundation
import UNogsAPI
import Combine

final class UNogsAPITests: XCTestCase {

    let sut = UNogsAPIClient()
    var disposabes: [AnyCancellable] = []

    override func tearDown() {
        disposabes.removeAll()
    }

    func testCountries() {
        assert(publisher: sut.countriesPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "34")
            XCTAssertEqual(response.objects.count, 34)
        }
    }

    func testNewReleases() {
        assert(publisher: sut.newReleasesPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "30")
            XCTAssertEqual(response.objects.count, 30)
        }
    }

    func testExpiring() {
        assert(publisher: sut.expiringPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "66")
            XCTAssertEqual(response.objects.count, 66)
        }
    }

    func testFilteredTitles() {
        assert(publisher: sut.filteredTitlesPublisher()) { response in
            response.objects.forEach { print($0) }
            XCTAssertEqual(response.count, "11106")
            XCTAssertEqual(response.objects.count, 100)
        }
    }

    static var allTests = [
        ("testCountries", testCountries),
        ("testNewReleases", testNewReleases),
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
