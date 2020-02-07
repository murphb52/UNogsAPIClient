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
        let testExpectation = expectation(description: #function)

        sut.fetchCountries()
            .sink(receiveCompletion: { (completion) in
                XCTAssertNil(completion.error)
                testExpectation.fulfill()
            },
                  receiveValue: { (response) in
                    XCTAssertEqual(response.count, "34")
                    XCTAssertEqual(response.objects.count, 34)
            })
            .store(in: &disposabes)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testNewReleases() {
        let testExpectation = expectation(description: #function)

        sut.fetchNewReleases()
            .sink(receiveCompletion: { (completion) in
                XCTAssertNil(completion.error)
                testExpectation.fulfill()
            },
                  receiveValue: { (response) in
                    response.objects.forEach { print($0) }
                    XCTAssertEqual(response.count, "89")
                    XCTAssertEqual(response.objects.count, 89)
            })
            .store(in: &disposabes)

        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testCountries", testCountries),
        ("testNewReleases", testNewReleases),
    ]
}

extension Subscribers.Completion {
    var error: Error? {
        switch self {
        case .failure(let error): return error
        case .finished: return nil
        }
    }
}
