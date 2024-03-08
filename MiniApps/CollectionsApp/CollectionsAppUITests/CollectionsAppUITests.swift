import XCTest

final class CollectionsAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testTableViewInteraction() {
        // Assert
        XCTAssertTrue(app.tables["MainTableView"].exists, "MainTableView should exist")
        
        // Act
        let tableView = app.tables["MainTableView"]
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell should exist")
        
        // Tap on the first cell
        firstCell.tap()
        
        // Assert
        XCTAssertTrue(app.navigationBars["Array"].exists, "Array navigation bar should exist")
    }
    
    func testTableViewNavigation() {
        // Act
        let tableView = app.tables["MainTableView"]
        
        // Tap on the second cell
        let secondCell = tableView.cells.element(boundBy: 1)
        secondCell.tap()
        
        // Assert
        XCTAssertTrue(app.navigationBars["Set"].exists, "Set navigation bar should exist")
        
        // Go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Assert
        XCTAssertTrue(app.navigationBars["Collections"].exists, "Collections navigation bar should exist")
        
        // Tap on the third cell
        let thirdCell = tableView.cells.element(boundBy: 2)
        thirdCell.tap()
        
        // Assert
        XCTAssertTrue(app.navigationBars["Dictionary"].exists, "Dictionary navigation bar should exist")
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
