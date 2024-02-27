import XCTest
@testable import ReverseWords

final class ReverseWordsTests: XCTestCase {

    var model: ReverseWordsModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        model = ReverseWordsModel()
    }

    override func tearDownWithError() throws {
        model = nil
        try super.tearDownWithError()
    }

    // Test reversing words in a string
    func testReverseWords() {
        
        // Given
        let inputText = "Foxminded cool 24/7"
        let expectedOutput = "dednimxoF looc 7/42"
        
        // When
        let revert = model.reverseWords(in: inputText)
        
        // Then
        XCTAssertEqual(revert, expectedOutput)
    }
    
    // Test reversing words in a string, ignoring non-letter characters
    func testReverseExceptAlphabeticSymbols() {
        let inputText = "a1bcd efg!h"
        let expectedOutput = "d1cba hgf!e"
        let revert = model.reverseExceptAlphabeticSymbols(in: inputText)
        XCTAssertEqual(revert, expectedOutput)
    }
    
    // Test reversing words in a string, ignoring a user-defined set of characters
    func testReverseIgnoredUserDefined() {
        let inputText = "abcd efgh"
        let excludedChars = "xl"
        let expectedOutput = "dcba hgfe"
        let revert = model.reverseIgnoredUserDefined(in: inputText, ignoredChars: excludedChars)
        XCTAssertEqual(revert, expectedOutput)
    }
    
    // Test reversing words in a string, ignoring a different user-defined set of characters
    func testReverseIgnoredUserDefinedWithCustomExclusions() {
        let inputText = "Foxminded cool 24/7"
        let excludedChars = "Foxminded"
        let expectedOutput = "Foxminded looc 7/42"
        let revert = model.reverseIgnoredUserDefined(in: inputText, ignoredChars: excludedChars)
        XCTAssertEqual(revert, expectedOutput)
    }
}
