//
//  LoginFormView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import SwiftUI

struct LoginFormView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    @Binding var loginErrorMessage: String?
    
    var validateLogin: () -> Bool
    var onLoginSuccess: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 1))
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .accessibilityIdentifier("EmailField")
                .accessibilityLabel("Email field")
                .accessibilityHint("Enter your email address")
            
            HStack {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .accessibilityIdentifier("PasswordField")
                        .accessibilityLabel("Password field")
                        .accessibilityHint("Enter your password. Currently visible.")
                } else {
                    SecureField("Password", text: $password)
                        .accessibilityIdentifier("PasswordField")
                        .accessibilityLabel("Password field")
                        .accessibilityHint("Enter your password. Currently hidden.")
                }
                Button { isPasswordVisible.toggle() } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .accessibilityLabel(isPasswordVisible ? "Hide password" : "Show password")
                        .accessibilityHint("Toggles password visibility")
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 1))
            
            Button("Forgot Password?") { /* handle forgot password */  onLoginSuccess() }
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.top, -10)
                .accessibilityIdentifier("Forgot Password?")
                .accessibilityLabel("Forgot Password")
                .accessibilityHint("Resets your password")
                .accessibilityAddTraits(.isButton)
            
            Button {
                if validateLogin() {
                    loginErrorMessage = nil
                    onLoginSuccess()
                } else {
                    loginErrorMessage = "Invalid email or password."
                }
            } label: {
                Text("Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 20)
            }
            .accessibilityIdentifier("LoginButton")
            .accessibilityLabel("Login button")
            .accessibilityHint("Attempts to log into your account")
            .accessibilityAddTraits(.isButton)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    LoginFormView(email: .constant("email"), password: .constant("password"), isPasswordVisible: .constant(false), loginErrorMessage: .constant("email"), validateLogin: {return true}, onLoginSuccess: { })
}
