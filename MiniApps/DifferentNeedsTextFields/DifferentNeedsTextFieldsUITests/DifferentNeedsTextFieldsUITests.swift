//
//  DifferentNeedsTextFieldsUITests.swift
//  DifferentNeedsTextFieldsUITests
//
//  Created by Mustafa Bekirov on 12.05.2023.
//

import XCTest

final class DifferentNeedsTextFieldsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTextFieldInteractions() throws {
        // Access the CustomView and its elements using accessibility identifiers
        let customView = app.otherElements["customView"]
        let nameLabel = customView.staticTexts["customViewNameLabel"]
        let inputTextField = customView.textFields["customViewInputTextField"]
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
