
import XCTest
@testable import UNogsAPI

final class UNogsAPIClientAsyncTests: XCTestCase {

    let sut = UNogsAPIClient(apiKey: "dummy_key")

    override func tearDown() {
        JSONStubManager.tearDown()
    }

    func testCountries() async throws {
        try JSONStubManager.setupStub(.countries)

        let response = try await sut.countries()
        
        XCTAssertEqual(response.count, "34")
        XCTAssertEqual(response.objects.count, 34)

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

    func testNewReleases() async throws {
        try JSONStubManager.setupStub(.newReleases(countryShortCode: "GB"))

        let response = try await sut.newReleases(countryShortCode: "GB")

        XCTAssertEqual(response.count, "36")
        XCTAssertEqual(response.objects.count, 36)
        // Verify object integrity if needed, similar to existing tests
        XCTAssertNotNil(response.objects.first?.id)
    }

    func testExpiring() async throws {
        try JSONStubManager.setupStub(.expiring(countryShortCode: "US"))

        let response = try await sut.expiring(countryShortCode: "US")

        XCTAssertEqual(response.count, "70")
        XCTAssertEqual(response.objects.count, 70)
        XCTAssertNotNil(response.objects.first?.id)
    }

    func testFilteredTitlesWithBlankQuery() async throws {
        let query = FilteredTitlesQuery()
        try JSONStubManager.setupStub(.filteredTitles(query: query))
        
        let response = try await sut.filteredTitles(query: query)
        
        XCTAssertEqual(response.count, "11118")
        XCTAssertEqual(response.objects.count, 100)
        XCTAssertNotNil(response.objects.first?.id)
    }

    func testFilteredTitlesWith7DaysNewQuery() async throws {
        let query = FilteredTitlesQuery(queryType: .getNew(days: 7),
                                        genreIdentifiers: [1,2,3])

        try JSONStubManager.setupStub(.filteredTitles(query: query))

        let response = try await sut.filteredTitles(query: query)

        XCTAssertEqual(response.count, "11118")
        XCTAssertEqual(response.objects.count, 100)
        XCTAssertNotNil(response.objects.first?.id)
    }

    func testGenres() async throws {
        try JSONStubManager.setupStub(.genres)
        
        let response = try await sut.genres()

        XCTAssertEqual(response.count, "517")
        XCTAssertEqual(response.objects.count, 517)
        XCTAssertEqual(response.objects.first?.name, "All Action")
        XCTAssertEqual(response.objects.first?.identifiers.count, 21)
    }

    func testAudioAndSubtitlesAnd() async throws {
        try JSONStubManager.setupStub(.frenchTitles)

        let query = FilteredTitlesQuery(audio: .french, subtitlesAudioAndOr: .and)
        let response = try await sut.filteredTitles(query: query)

        XCTAssertEqual(response.count, "2645")
        XCTAssertEqual(response.objects.count, 100)
        XCTAssertEqual(response.objects.first?.title, "Breaking Bad")
        XCTAssertEqual(response.objects.first?.id, "70143836")
    }
}
