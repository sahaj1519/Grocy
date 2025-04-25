//
//  SignUpViewViewModelTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy


struct SignUpViewModelTests {
    
    @Test func validUserInputShouldPass() {
        let viewModel = SignUpView.ViewModel()
        
        viewModel.name = "John Doe"
        viewModel.email = "john@example.com"
        viewModel.phone = "9823746578"
        viewModel.password = "SecurePass123"

        #expect(viewModel.currentInputUser.isSignUpDataValid)
    }

    @Test func invalidEmailShouldFail() {
        let viewModel = SignUpView.ViewModel()
        viewModel.email = "invalid-email"

        assert(!viewModel.currentInputUser.isSignUpDataValid)
    }

    @Test func passwordVisibilityToggleWorks() {
        let viewModel = SignUpView.ViewModel()
        assert(!viewModel.isPasswordVisible)

        viewModel.isPasswordVisible = true
        assert(viewModel.isPasswordVisible)
    }
}
