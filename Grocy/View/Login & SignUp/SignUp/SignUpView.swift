//
//  SignUpView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 23/04/25.
//
import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var user: DataModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.green, Color.blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .accessibilityLabel("App Logo")
                            .accessibilityHint("This is the app logo.")
                        
                        Text("Create Account")
                            .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                        
                        VStack(spacing: 16) {
                            InputField(placeholder: "Full Name", text: $viewModel.name, accessibilityID: "SignUp_NameField")
                                .onChange(of: viewModel.name) { viewModel.showInputInvalidError = false }
                                .accessibilityLabel("Enter your full name")
                                .accessibilityHint("Type your full name here.")
                            
                            InputField(placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress, accessibilityID: "SignUp_EmailField")
                                .onChange(of: viewModel.email) {
                                    viewModel.showInputInvalidError = false
                                    viewModel.showEmailAlreadyExistsError = false
                                }
                                .accessibilityLabel("Enter your email address")
                                .accessibilityHint("Type your email address here.")
                            
                            InputField(placeholder: "Phone", text: $viewModel.phone, keyboardType: .phonePad, accessibilityID: "SignUp_PhoneField")
                                .onChange(of: viewModel.phone) { viewModel.showInputInvalidError = false }
                                .accessibilityLabel("Enter your phone number")
                                .accessibilityHint("Type your 10-digit phone number here.")
                            
                            if !viewModel.currentInputUser.isValidPhoneNumber && !viewModel.phone.isEmpty {
                                Text("Please enter a valid 10-digit phone number.")
                                    .foregroundColor(.red)
                                    .font(.footnote)
                            }
                            
                            PasswordField(isPasswordVisible: $viewModel.isPasswordVisible, password: $viewModel.password)
                                .onChange(of: viewModel.password) { viewModel.showInputInvalidError = false }
                                .accessibilityLabel("Enter your password")
                                .accessibilityHint("Type your password here. Tap the eye icon to toggle visibility.")
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        
                        SignUpButton() {
                            Task {
                                
                                guard viewModel.currentInputUser.isSignUpDataValid else {
                                    viewModel.showInputInvalidError = true
                                    return
                                }
                                do {
                                    try await user.loadUserData()
                                    user.optionalUser = viewModel.currentInputUser
                                    
                                    if await user.userAlreadyExists(viewModel.currentInputUser) {
                                        viewModel.showEmailAlreadyExistsError = true
                                    } else {
                                        user.addUser(viewModel.currentInputUser)
                                        viewModel.showHomeView = true
                                    }
                                } catch {
                                    print("Failed to load user data: \(error)")
                                }
                            }
                        }
                        .accessibilityLabel("Sign Up")
                        .accessibilityHint("Tap to create a new account.")
                        
                        if viewModel.showInputInvalidError {
                            Text("Please complete all fields correctly before signing up.")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.top, 5)
                                .accessibilityLabel("Error: Please complete all fields correctly before signing up.")
                                .accessibilityValue("This is an error message.")
                        }
                        
                        if viewModel.showEmailAlreadyExistsError {
                            Text("An account with this email already exists.")
                                .foregroundColor(.white).padding(.top, 5)
                                .accessibilityLabel("Error: An account with this email already exists.")
                                .accessibilityValue("This is an error message.")
                        }
                        
                        Button("Already have an account? Login") { viewModel.showLoginView = true }
                            .foregroundColor(.white).padding(.top, 10)
                            .accessibilityLabel("Go to login page")
                            .accessibilityHint("Tap to navigate to the login screen.")
                        
                        Spacer()
                    }
                    .padding()
                }
                .padding(.top)
            }
            .fullScreenCover(isPresented: $viewModel.showLoginView) { LoginView(user: user) }
            .fullScreenCover(isPresented: $viewModel.showHomeView) { ContentView(user: user) }
            //.navigationTitle("Sign Up")
            .accessibilityLabel("Sign Up Screen")
            .accessibilityHint("This is the sign-up screen where you can create a new account.")
            
        }
    }
}

#Preview {
    SignUpView(user: .preview)
}
