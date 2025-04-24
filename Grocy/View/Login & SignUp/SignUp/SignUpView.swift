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
    
    @State private var showHomeView = false
    @State private var showLoginView = false
    @State private var isPasswordVisible = false
    @State private var showEmailAlreadyExistsError = false
    @State private var showInputInvalidError = false

    @State private var email = ""
    @State private var phone = ""
    @State private var name = ""
    @State private var password = ""
    
    private var currentInputUser: User {
        User(name: name, email: email, password: password, phone: phone, orders: [], address: [])
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.green, Color.blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    Text("Create Account")
                        .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                    
                    VStack(spacing: 16) {
                        InputField(placeholder: "Full Name", text: $name)
                            .onChange(of: name) { showInputInvalidError = false }
                        InputField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                            .onChange(of: email) {
                                   showInputInvalidError = false
                                   showEmailAlreadyExistsError = false
                               }
                        InputField(placeholder: "Phone", text: $phone, keyboardType: .phonePad)
                            .onChange(of: phone) { showInputInvalidError = false }
                        
                        if !currentInputUser.isValidPhoneNumber && !phone.isEmpty {
                            Text("Please enter a valid 10-digit phone number.")
                                .foregroundColor(.red)
                                .font(.footnote)
                        }

                        PasswordField(isPasswordVisible: $isPasswordVisible, password: $password)
                            .onChange(of: password) { showInputInvalidError = false }
                    }
                    .padding().background(.ultraThinMaterial)
                    .cornerRadius(20).foregroundColor(.black).padding(.horizontal)
                    
                    SignUpButton() {
                        Task {
                            
                            guard currentInputUser.isSignUpDataValid else {
                                showInputInvalidError = true
                                return
                            }
                            do {
                                try await user.loadUserData()
                                user.optionalUser = currentInputUser
                                
                                if await user.userAlreadyExists(currentInputUser) {
                                    showEmailAlreadyExistsError = true
                                } else {
                                    user.addUser(currentInputUser)
                                    showHomeView = true
                                }
                            } catch {
                                print("Failed to load user data: \(error)")
                            }
                        }
                    }
                    
                    if showInputInvalidError {
                        Text("Please complete all fields correctly before signing up.")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.top, 5)
                    }
                    
                    if showEmailAlreadyExistsError {
                        Text("An account with this email already exists.")
                            .foregroundColor(.white).padding(.top, 5)
                    }
                    
                    Button("Already have an account? Login") { showLoginView = true }
                        .foregroundColor(.white).padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .fullScreenCover(isPresented: $showLoginView) { LoginView(user: user) }
            .fullScreenCover(isPresented: $showHomeView) { ContentView(user: user) }
        }
    }
}

#Preview {
    SignUpView(user: .preview)
}
