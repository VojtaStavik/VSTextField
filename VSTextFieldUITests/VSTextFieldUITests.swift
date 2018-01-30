//
//  VSTextFieldUITests.swift
//  VSTextFieldUITests
//
//  Created by Dave Neff on 11/8/17.
//

import XCTest
@testable import VSTextField

class VSTextFieldUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testTextFieldExists() {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["UUID"]/*[[".cells.staticTexts[\"UUID\"]",".staticTexts[\"UUID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        XCTAssert(textField.exists, "Text field in detail controller not found")
    }
    
    func testUUIDFormatting() {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["UUID"]/*[[".cells.staticTexts[\"UUID\"]",".staticTexts[\"UUID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        textField.tap()
        textField.typeText("e539bb70d744413384f835f11ec92ed4")
        
        guard let text = textField.value as? String else {
            XCTFail("Failed to extract final text value from text field")
            return
        }
        
        XCTAssert(text == "E539BB70-D744-4133-84F8-35F11EC92ED4", "UUID did not match expected format")
    }
    
    func testSSNFormatting() {
        app.tables.staticTexts["Social Security Number"].tap()
        
        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        textField.tap()
        textField.typeText("123001234")
        
        guard let text = textField.value as? String else {
            XCTFail("Failed to extract final text value from text field")
            return
        }
                
        XCTAssert(text == "123-00-1234", "Social Security Number did not match expected format")
    }
    
    func testPhoneNumberFormatting() {
        app.tables.staticTexts["Phone Number"].tap()
        
        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        textField.tap()
        textField.typeText("8001231234")
        
        guard let text = textField.value as? String else {
            XCTFail("Failed to extract final text value from text field")
            return
        }
        
        XCTAssert(text == "800-123-1234", "Phone Number did not match expected format")
    }
    
    func testCustomFormatting() {
        app.tables.staticTexts["Custom"].tap()
        
        let alertTextField = app.alerts["Enter Custom Formatting"].collectionViews.textFields["(###) ###-####"]
        alertTextField.typeText("(###) ###-####")
        app.alerts["Enter Custom Formatting"].buttons["Format"].tap()
        
        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        textField.tap()
        textField.typeText("8001231234")

        guard let text = textField.value as? String else {
            XCTFail("Failed to extract final text value from text field")
            return
        }
        
        XCTAssert(text == "(800) 123-1234", "Custom formatting did not match expected format")
    }
    
    func testNoFormatting() {
        app.tables.staticTexts["No Formatting"].tap()

        let textField = app.textFields[ExampleDetailController.identifierForTesting]
        textField.tap()
        textField.typeText("UI testing is the best. 1st out of 1,300,589, for sure!")

        guard let text = textField.value as? String else {
            XCTFail("Failed to extract final text value from text field")
            return
        }
        
        XCTAssert(text == "UI testing is the best. 1st out of 1,300,589, for sure!")
    }
}
