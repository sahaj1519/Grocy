//
//  LoginViewViewModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation

extension LoginView {
    
    @Observable
    class ViewModel {
        
        var email = ""
        var password = ""
        var showHomeView = false
        var showSignUp = false
        var forgotPasswordTapped = false
        var loginErrorMessage: String?
        var isPasswordVisible = false
        
       
        
    }
}
