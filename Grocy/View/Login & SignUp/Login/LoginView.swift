//
//  LoginView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 23/04/25.
//

import SwiftUI

struct LoginView: View {
    @Bindable var user: DataModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var showHomeView = false
    @State private var showSignUp = false
    @State private var forgotPasswordTapped = false
    @State private var loginErrorMessage: String?
    @State private var isPasswordVisible = false
    
    private func validateLogin() -> Bool {
        if let matchedUser = user.users.first(where: {
            $0.email.lowercased() == email.lowercased() && $0.password == password
        }) {
            user.optionalUser = matchedUser
            user.isLoggedIn = true
            UserDefaults.standard.set(true, forKey: "loggedIn")
            UserDefaults.standard.set(matchedUser.email, forKey: "loggedInEmail")
            return true
        }
        return false
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.green.opacity(0.8), Color.blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Background circles and rectangles
            Circle()
                .fill(.white.opacity(0.05))
                .frame(width: 300, height: 300)
                .blur(radius: 60)
                .offset(x: -150, y: -200)
            
            RoundedRectangle(cornerRadius: 50)
                .fill(.white.opacity(0.04))
                .frame(width: 350, height: 400)
                .blur(radius: 40)
                .rotationEffect(.degrees(30))
                .offset(x: 100, y: 250)
            
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Text("Grocy")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                LoginFormView(
                    email: $email,
                    password: $password,
                    isPasswordVisible: $isPasswordVisible,
                    loginErrorMessage: $loginErrorMessage,
                    validateLogin: validateLogin,
                    onLoginSuccess: {
                        user.isLoggedIn = true
                        Task { @MainActor in 
                            try? await user.saveUserData()
                        }
                        showHomeView = true
                    }
                )
                
                ErrorMessageView(message: loginErrorMessage)
                
                Button("New here? Create an account") { showSignUp = true }
                    .foregroundColor(.blue)
                    .padding(.bottom)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .fullScreenCover(isPresented: $showSignUp) { SignUpView(user: user) }
            .fullScreenCover(isPresented: $showHomeView) { ContentView(user: user) }
            .fullScreenCover(isPresented: $forgotPasswordTapped) { ContentView(user: user) }  // Change to ForgotPasswordView later
        }
    }
}

#Preview {
    LoginView(user: .preview)
}
