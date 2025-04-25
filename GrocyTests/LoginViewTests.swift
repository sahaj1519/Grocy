//
//  LoginViewTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy


struct LoginViewTests {
    
    @Test func validUserCanLogIn() {
        let userModel = DataModel()
        let validUser = User(name: "John Doe", email: "john@example.com", password: "SecurePass123", phone: "1234567890", orders: [], address: [])
        userModel.users.append(validUser)
        
        let viewModel = LoginView.ViewModel()
        viewModel.email = validUser.email
        viewModel.password = validUser.password
        
        let loginView = LoginView(user: userModel, viewModel: viewModel)
        
        assert(loginView.validateLogin())
        assert(userModel.isLoggedIn)
        assert(userModel.optionalUser?.email == validUser.email)
    }
    
    @Test func invalidUserShouldFailLogin() {
        let userModel = DataModel()
        let validUser = User(name: "John Doe", email: "john@example.com", password: "SecurePass123", phone: "1234567890", orders: [], address: [])
        userModel.users.append(validUser)
        
        let viewModel = LoginView.ViewModel()
        viewModel.email = "wrong@example.com"
        viewModel.password = "wrongpassword"
        
        let loginView = LoginView(user: userModel, viewModel: viewModel)
        
        #expect(loginView.validateLogin() == false)
        #expect(userModel.isLoggedIn == false)
        #expect(userModel.optionalUser != nil)
    }
    
    @Test func loginStatePersistsInUserDefaults() async {
        let userModel = DataModel()
        let validUser = User(name: "John Doe", email: "john@example.com", password: "SecurePass123", phone: "1234567890", orders: [], address: [])
        userModel.users.append(validUser)

        let viewModel = LoginView.ViewModel()
        viewModel.email = validUser.email
        viewModel.password = validUser.password

        let loginView = LoginView(user: userModel, viewModel: viewModel)
        
        let loginSuccess = await loginView.validateLogin() // Capture the return value

        // Wait briefly for UserDefaults to update
        try? await Task.sleep(nanoseconds: 500_000_000)  // Wait 0.5 seconds

        let storedLoginState = UserDefaults.standard.bool(forKey: "loggedIn")
        let storedEmail = UserDefaults.standard.string(forKey: "loggedInEmail")

        assert(loginSuccess, "User login should be successful")
        assert(userModel.isLoggedIn, "User should be marked as logged in")
        assert(storedLoginState, "UserDefaults should store login state as true")
        assert(storedEmail == validUser.email, "Stored email should match logged-in user")
    }



}
