//
//  DifferentNeedsTextFieldsTests.swift
//  DifferentNeedsTextFieldsTests
//
//  Created by Mustafa Bekirov on 12.05.2023.
//

import XCTest
@testable import DifferentNeedsTextFields

final class DifferentNeedsTextFieldsTests: XCTestCase {
    
    var viewController: ViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerIdentifier") as? ViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }

    func testThirdViewInputMask() throws {
        // Set the input text field's text
        viewController.thirdView.inputTextField.text = "ab1234"
        
        // Invoke the shouldChangeCharactersIn delegate method to apply the input mask
        let result = viewController.textField(viewController.thirdView.inputTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "")
        
        // Verify that the input text field's text is updated with the input mask applied
        XCTAssertEqual(viewController.thirdView.inputTextField.text, "ab-")
        
        // Verify that the shouldChangeCharactersIn delegate method returns false to prevent further changes
        XCTAssertFalse(result)
    }
    
    func testFifthViewPasswordRequirements() {
        // Set the input text field's text
        viewController.fifthView.inputTextField.text = "Abcdefg1"
        
        // Invoke the shouldChangeCharactersIn delegate method to trigger password requirements check
        let result = viewController.textField(viewController.fifthView.inputTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "")
        
        // Verify that the lengthCharLabel is green indicating the length requirement is met
        XCTAssertEqual(viewController.lengthCharLabel.textColor, .green)
        
        // Verify that the digitLabel is green indicating the digit requirement is met
        XCTAssertEqual(viewController.digitLabel.textColor, .green)
        
        // Verify that the lowercaseLabel is green indicating the lowercase letter requirement is met
        XCTAssertEqual(viewController.lowercaseLabel.textColor, .green)
        
        // Verify that the capitalRequiredLabel is green indicating the capital letter requirement is met
        XCTAssertEqual(viewController.capitalRequiredLabel.textColor, .green)
        
        // Verify that the input text field's border is green indicating all requirements are met
        XCTAssertEqual(viewController.fifthView.inputTextField.layer.borderColor, UIColor.green.cgColor)
        
        // Verify that the shouldChangeCharactersIn delegate method returns true to allow further changes
        XCTAssertTrue(result)
    }
}
