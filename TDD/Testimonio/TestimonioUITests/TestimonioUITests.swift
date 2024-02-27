//
//  TestimonioUITests.swift
//  TestimonioUITests
//
//  Created by Mustafa Bekirov on 16.04.2023.
//

import XCTest

final class TestimonioUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScreenLogin() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["LoginTF"].tap()
        app.textFields["LoginTF"].typeText("Bar")
        
        app.buttons["Next:"].tap()
        
        app.textFields["PasswordTF"].typeText("Baz")
        
        app.buttons["Done"].tap()
        
        XCTAssert(app.alerts["Warning"].descendants(matching: .staticText)["Invalid Fields"].waitForExistence(timeout: 1.0))
    }
    
    func testNextScreenExistsAfterLogin() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["LoginTF"].tap()
        app.textFields["LoginTF"].typeText("Foo")
        
        app.buttons["Next:"].tap()
        
        app.textFields["PasswordTF"].typeText("abc123")
        
        app.buttons["Done"].tap()
        
        XCTAssert(app.navigationBars["Main"].waitForExistence(timeout: 1.0))
    }
}
