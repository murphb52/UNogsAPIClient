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

    func testExample() {
        let testExpectation = expectation(description: #function)

        sut.fetchCountries()
            .sink(receiveCompletion: { (completion) in },
                  receiveValue: { (countriesResponse) in
                    countriesResponse.countries.forEach { print($0) }
                    XCTAssertEqual(countriesResponse.count, "34")
                    XCTAssertEqual(countriesResponse.countries.count, 34)
                    testExpectation.fulfill()
            })
            .store(in: &disposabes)

        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
