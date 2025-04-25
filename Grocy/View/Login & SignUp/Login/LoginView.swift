//
//  LoginView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 23/04/25.
//

import SwiftUI

struct LoginView: View {
    @Bindable var user: DataModel
    @State var viewModel = ViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    func validateLogin() -> Bool {
        if let matchedUser = user.users.first(where: {
            $0.email.lowercased() == viewModel.email.lowercased() && $0.password == viewModel.password
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
            ScrollView(showsIndicators: false) {
                if !isLandscape {
                    Spacer()
                        .frame(height: 120)
                }
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .accessibilityHidden(true)
                    
                    Text("Grocy")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityLabel("Grocy app logo and name")
                    
                    LoginFormView(
                        email: $viewModel.email,
                        password: $viewModel.password,
                        isPasswordVisible: $viewModel.isPasswordVisible,
                        loginErrorMessage: $viewModel.loginErrorMessage,
                        validateLogin: validateLogin,
                        onLoginSuccess: {
                            user.isLoggedIn = true
                            Task { @MainActor in
                                try? await user.saveUserData()
                            }
                            viewModel.showHomeView = true
                        }
                    )
                    
                    ErrorMessageView(message: viewModel.loginErrorMessage)
                    
                    Button("New here? Create an account") { viewModel.showSignUp = true }
                        .foregroundColor(.blue)
                        .padding(.bottom)
                        .accessibilityLabel("New here? Create an account")
                        .accessibilityHint("Opens the sign-up screen")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(40)
                .padding(.horizontal, 20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                .fullScreenCover(isPresented: $viewModel.showSignUp) { SignUpView(user: user) }
                .fullScreenCover(isPresented: $viewModel.showHomeView) { ContentView(user: user) }
                .fullScreenCover(isPresented: $viewModel.forgotPasswordTapped) { ContentView(user: user) }  // Change to ForgotPasswordView later
            }
            .padding(.top)
        }
    }
}

#Preview {
    LoginView(user: .preview)
}
