import XCTest

final class ReverseWordsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }
    
    func testReverseButtonAction() {
        // Enter a string to reverse in the text field
        app.navigationBars["Reverse Words"].buttons["Anagram"].tap()
        let toReverseTextField = app.textFields["toReverseTextField"]
        toReverseTextField.tap()
        toReverseTextField.typeText("Hello World")
        
        // Check if the result label displays the correct result
        let resultLabel = app.staticTexts["resultLabel"]
        XCTAssertEqual(resultLabel.label, "olleH lroW ")
    }
    
    func testSegmentedControlAction() {
        // Tap the second segment of the segmented control
        app.navigationBars["Reverse Words"].buttons["Anagram"].tap()
        let segmentedControl = app.segmentedControls["changeLogic"]
        segmentedControl.tap()
        segmentedControl.buttons.element(boundBy: 1).tap()
        
        // Check if the ignored text field is visible
        let ignoredTextField = app.textFields["toIgnoreTextField"]
        XCTAssertTrue(ignoredTextField.exists)
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
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
