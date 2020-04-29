import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StencilProviderTests.allTests),
    ]
}
#endif
