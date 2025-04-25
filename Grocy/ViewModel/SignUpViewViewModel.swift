//
//  SignUpViewViewModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation

extension SignUpView {
    @Observable
    class ViewModel {
        
        var showHomeView = false
        var showLoginView = false
        var isPasswordVisible = false
        var showEmailAlreadyExistsError = false
        var showInputInvalidError = false
        
        var email = ""
        var phone = ""
        var name = ""
        var password = ""
        
        var currentInputUser: User {
            User(name: name, email: email, password: password, phone: phone, orders: [], address: [])
        }
        
    }
}
