//  CardFormUITests.swift
//  PaymentKit
//
//  Created by lla.

import XCTest

final class CardFormUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testFillingOutFormAndSubmitting() {
        let cardNumberField = app.textFields["Card number"]
        let monthField = app.textFields["Expiration month"]
        let yearField = app.textFields["Expiration year"]
        let cvvField = app.secureTextFields["CVV code"]
        let payButton = app.buttons["Pay button"]

        XCTAssertTrue(cardNumberField.exists)
        XCTAssertTrue(monthField.exists)
        XCTAssertTrue(yearField.exists)
        XCTAssertTrue(cvvField.exists)

        cardNumberField.tap()
        cardNumberField.typeText("4242424242424242")

        monthField.tap()
        monthField.typeText("12")

        yearField.tap()
        yearField.typeText("99")

        cvvField.tap()
        cvvField.typeText("123")

        XCTAssertTrue(payButton.isEnabled)
        payButton.tap()

        let successLabel = app.staticTexts["Payment completed successfully"]
        let errorLabel = app.staticTexts["Payment failed"]

        let successExists = successLabel.waitForExistence(timeout: 5)
        let errorExists = errorLabel.waitForExistence(timeout: 5)

        XCTAssertTrue(successExists || errorExists, "Neither success nor error message appeared")
    }
}
