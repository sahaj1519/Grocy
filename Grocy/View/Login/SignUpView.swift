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
    
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var name = ""
    
    @State private var showEmailAlreadyExistsError = false
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
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                    VStack(spacing: 16) {
                        TextField("Full Name", text: $name)
                            .textContentType(.name)
                        
                        Divider()
                        
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        
                        Divider()
                        
                        TextField("Phone", text: $phone)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                        
                        if !currentInputUser.isValidPhoneNumber {
                            Text("Please enter a valid 10-digit phone number.")
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        
                        Divider()
                        
                        HStack {
                            Group {
                                if isPasswordVisible {
                                    TextField("Password", text: $password)
                                } else {
                                    SecureField("Password", text: $password)
                                }
                            }
                            .textContentType(.password)
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        
                        Divider()
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    
                    Button {
                        Task {
                            do {
                                try await user.loadUserData()
                            } catch {
                                print("Failed to load user data: \(error)")
                            }
                            
                            user.optionalUser = currentInputUser 
                            
                            let exists = await user.userAlreadyExists(currentInputUser)

                            if exists {
                                showEmailAlreadyExistsError = true
                            } else {
                                user.addUser(currentInputUser)
                                showHomeView = true
                            }
                        }
                    } label: {
                        Text("Sign Up")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(currentInputUser.isSignUpDataValid ? Color.green : Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 2)
                    }
                    
                    .padding(.top)
                    .disabled(!currentInputUser.isSignUpDataValid)
                    
                    if showEmailAlreadyExistsError {
                        Text("An account with this email already exists.")
                            .foregroundColor(.white)
                            .padding(.top, 5)
                    }

                    
                    Button("Already have an account? Login") {
                        showLoginView = true
                    }
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    
                    
                    Spacer()
                }
                .padding()
            }
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView(user: user)
            }
            
            .fullScreenCover(isPresented: $showHomeView) {
                ContentView(user: user)
            }
        }
    }
}

#Preview {
    SignUpView(user: .preview)
}
