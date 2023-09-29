//
//  UIDemoUITests.swift
//  UIDemoUITests
//
//  Created by Mustafa Bekirov on 10.04.2023.
//

import XCTest

final class UIDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testInvalidLoginProgressSpinnerIsHidden() {
        let validPassword = "invalidPassword"
        let validUserName = "CodePro"
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app.buttons["Login"].tap()
        app.alerts["Missing Credentials"].buttons["Ok"].tap()
        
        let activityIndicatorView = app.activityIndicators["In progress"]
        XCTAssertFalse(activityIndicatorView.exists)
    }
    
    func testInvalidLoginMissingCredentialsAlertIsShown() {
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app.textFields["Username"].tap()
        app.buttons["Login"].tap()
        
        let alertDialog = app.alerts["Missing Credentials"]
        
        XCTAssertTrue(alertDialog.exists)
        
        alertDialog.buttons["Ok"].tap()
    }
    
    func testValidLoginSuccess() {
        
        let validPassword = "abc123"
        let validUserName = "CodePro"
        
        let app = XCUIApplication()
        
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        
        let userNameTextField = app.textFields["Username"]
        XCTAssertTrue(userNameTextField.exists)
        
        userNameTextField.tap()
        
        userNameTextField.typeText(validUserName)
        
        let passwordTestField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTestField.exists)
        passwordTestField.tap()
        passwordTestField.typeText(validPassword)
        
        app.buttons["Login"].tap()
        
        let downloadCell = app.tables.staticTexts["My Downloads"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
