import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UNogsAPITests.allTests),
        testCase(CodableConformanceTests.allTests)
    ]
}
#endif
