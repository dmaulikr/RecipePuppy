import XCTest

class RecipePuppyUITests: XCTestCase {
    var application: XCUIApplication!
    var searchBar: XCUIElement!

    override func setUp() {
        super.setUp()

        application = XCUIApplication()
        application.launch()

        searchBar = application.searchFields.element
    }

    func test() {
        XCTAssert(numberOfCells() == 0)

        enterSearchCriteria("omelet")
        XCTAssert(numberOfCells() == 20)

        enterSearchCriteria("maggots")
        XCTAssert(numberOfCells() == 2)
    }
}

// MARK: - Helpers

extension RecipePuppyUITests {

    func enterSearchCriteria(_ searchCriteria: String) {
        searchBar.tap()

        let currentString = searchBar.value as! String // swiftlint:disable:this force_cast
        var deleteString: String = ""
        for _ in currentString.characters {
            deleteString += "\u{8}"
        }
        searchBar.typeText(deleteString)

        searchBar.typeText(searchCriteria)
    }

    func numberOfCells() -> UInt {
        return application.tables.cells.count
    }
}
