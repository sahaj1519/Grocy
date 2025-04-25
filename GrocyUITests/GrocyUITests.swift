//
//  GrocyAppUITests.swift
//  GrocyUITests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import XCTest

class GrocyAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testAppLaunchShowsLogin() throws {
        // Wait for the login button to appear after launch (post-splash)
        let loginButton = app.buttons["LoginButton"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 10), "Login button should appear after app launch")
    }
    
    func testLoginFunctionality() throws {
        // 1. Tap Login to go to login screen
        let loginButton = app.buttons["LoginButton"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 10), "Login button should be visible")
        loginButton.tap()
        
        // 2. Wait for login fields
        let emailField = app.textFields["EmailField"]
        let passwordField = app.secureTextFields["PasswordField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5), "Email field should appear")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5), "Password field should appear")
        
        // 3. Enter credentials
        emailField.tap(); emailField.typeText("akia@email.com")
        passwordField.tap(); passwordField.typeText("password")
        
        // 4. Submit
        let submitButton = app.buttons["LoginButton"]
        XCTAssertTrue(submitButton.exists, "Submit login button should exist")
        submitButton.tap()
        
        // 5. Verify Home (Shop tab) appears
        let shopTab = app.tabBars.buttons["Shop"]
        XCTAssertTrue(shopTab.waitForExistence(timeout: 10), "Shop tab should appear after successful login")
        let meTab = app.tabBars.buttons["Account"]
        meTab.tap();
        XCTAssertTrue(meTab.waitForExistence(timeout: 10), "Me tab should appear")
        let logoutButton = app.buttons["Logout"]
        logoutButton.tap();
        let newloginButton = app.buttons["LoginButton"]
        XCTAssertTrue(newloginButton.waitForExistence(timeout: 10), "Login button should be visible")
        
    }
    
    // MARK: - Test Signup Flo
    func testSignUpFunctionality() throws {
        // 1. Tap "New here? Create an account"
        let newAccountButton = app.buttons["New here? Create an account"]
        XCTAssertTrue(newAccountButton.waitForExistence(timeout: 10), "Sign-up trigger should appear")
        newAccountButton.tap()
        
        // 2. Wait for sign-up form fields
        let nameField = app.textFields["SignUp_NameField"]
        let emailField = app.textFields["SignUp_EmailField"]
        let phoneField = app.textFields["SignUp_PhoneField"]
        let passwordField = app.secureTextFields["SignUp_PasswordField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 1), "Full Name field should appear")
        XCTAssertTrue(emailField.waitForExistence(timeout: 1), "Email field should appear")
        XCTAssertTrue(phoneField.waitForExistence(timeout: 1), "Phone field should appear")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 1), "Password field should appear")
        
        // 3. Enter valid data
        nameField.tap(); nameField.typeText("John Doe")
        emailField.tap(); emailField.typeText("johndoe5@example.com")
        phoneField.tap(); phoneField.typeText("9822345623")
        passwordField.tap(); passwordField.typeText("newpassword123")
        
        // 4. Tap Sign Up
        let signUpButton = app.buttons["SignUp_Button"]
        XCTAssertTrue(signUpButton.waitForExistence(timeout: 5), "Sign Up button should exist")
        signUpButton.tap()
        
        // 5. Verify Home (Shop tab) appears
        let shopTab = app.tabBars.buttons["Shop"]
        XCTAssertTrue(shopTab.waitForExistence(timeout: 5), "Shop tab should appear after sign-up")
    }
    
    
    
    // MARK: - Test ExploreView After Signup
    
    func testExploreViewAfterSignup() throws {
        // 1. Tap Login to go to login screen
        let loginButton = app.buttons["Forgot Password?"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 10), "Forgot button should be visible")
        loginButton.tap()
        
        // Switch to Explore tab
        let exploreTab = app.tabBars.buttons["Explore"]
        XCTAssertTrue(exploreTab.waitForExistence(timeout: 5), "Explore tab should be available")
        exploreTab.tap()
        
        // Explore title
        let exploreTitle = app.navigationBars.staticTexts["Find Products"]
        XCTAssertTrue(exploreTitle.waitForExistence(timeout: 3), "ExploreView should load after tapping Explore tab")
        
        //  Tap a category (add correct identifier to `CategoryGridView`)
        let categoryTile = app.otherElements["Explore_Category_Vegetables"]
        XCTAssertTrue(categoryTile.waitForExistence(timeout: 3), "Vegetables category should exist")
        categoryTile.tap()
        
        //  Tap a product (use identifier like `"Explore_Product_Tomato"`)
        let productTile = app.otherElements["Explore_Product_Tomatoes"]
        XCTAssertTrue(productTile.waitForExistence(timeout: 5), "Tomatoes product should appear")
        productTile.tap()
        
        //  Product detail view check
        let detailName = app.otherElements["ProductDetail_Tomatoes"]
        XCTAssertTrue(detailName.waitForExistence(timeout: 5), "Product detail view should appear")
    }
    
    func testInvalidLogin() throws {
        // 1. Ensure we're on the Login screen (app should present it by default)
        
        // 2. Locate the email and password fields by their identifiers
        let emailField = app.textFields["EmailField"]
        let passwordField = app.secureTextFields["PasswordField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5), "Email field should appear")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5), "Password field should appear")
        
        // 3. Enter invalid credentials
        emailField.tap()
        emailField.typeText("invaliduser@example.com")
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        // 4. Tap the Login button
        let loginButton = app.buttons["LoginButton"]
        XCTAssertTrue(loginButton.exists, "Login button should exist")
        loginButton.tap()
        
        // 5. Verify error message appears
        let errorMsg = app.staticTexts["LoginErrorMessage"]
        XCTAssertTrue(errorMsg.waitForExistence(timeout: 5),
                      "Error message should appear for invalid login")
    }
    
}
