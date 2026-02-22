import XCTest

final class StudyDeckUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchShowsDemoToggle() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.switches["Demo Mode"].exists)
    }
}
