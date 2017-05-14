import XCTest

@testable import RecipePuppy

class RecipePuppyTests: XCTestCase {

    func testBundleDisplayName() {
        XCTAssert(Bundle.displayName() == "RecipePuppy")
    }

    func testStringTrim() {
        XCTAssert(" 123 456 789 ".trim() == "123 456 789")
    }
}
