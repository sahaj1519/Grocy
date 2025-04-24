//
//  UserDetailsView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct UserDetailsView: View {
    @Bindable var user: DataModel
    @State private var isEdit = false
    @State private var isPasswordVisible = false
    @State private var passwordStrength: String = "Weak"
    
    var body: some View {
        VStack(spacing: 10) {
            userTextField(title: "Name", text: $user.currentUser.name, contentType: .name)
            userTextField(title: "Email", text: $user.currentUser.email, contentType: .emailAddress)
            userTextField(title: "Phone Number", text: $user.currentUser.phone, contentType: .telephoneNumber)

            if !user.currentUser.isValidPhoneNumber && isEdit {
                Text("Please enter a valid 10-digit phone number.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            passwordField
            
            if isEdit {
                Text("Password Strength: \(passwordStrength)")
                    .font(.footnote)
                    .foregroundColor(passwordStrength == "Weak" ? .red : .green)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .disabled(!isEdit)

        actionButtons
            .buttonStyle(.plain)
    }

    private func userTextField(title: String, text: Binding<String>, contentType: UITextContentType) -> some View {
        TextField(title, text: text)
            .padding(5)
            .background(isEdit ? Color.white : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isEdit ? Color.green : Color.clear, lineWidth: 1)
            )
            .textContentType(contentType)
    }

    private var passwordField: some View {
        HStack {
            Group {
                if isPasswordVisible {
                    TextField("Password", text: $user.currentUser.password)
                } else {
                    SecureField("Password", text: $user.currentUser.password)
                }
            }
            .padding(5)
            .background(isEdit ? Color.white : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isEdit ? Color.green : Color.clear, lineWidth: 1)
            )
            .textContentType(.password)

            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
    }

    private var actionButtons: some View {
        VStack {
            if !isEdit {
                editButton
            } else {
                HStack(spacing: 12) {
                    saveButton
                    cancelButton
                }
                .padding(.top, 10)
            }
        }
    }

    private var editButton: some View {
        Button {
            isEdit = true
            isPasswordVisible = false
        } label: {
            actionLabel("pencil", "Edit")
                .background(.blue)
        }
        .padding(.top, 10)
    }

    private var saveButton: some View {
        Button {
            Task { @MainActor in
                try await user.saveUserData()
                isEdit = false
                isPasswordVisible = false
            }
        } label: {
            actionLabel("checkmark", "Save")
                .background(.green)
        }
    }

    private var cancelButton: some View {
        Button {
            isEdit = false
            isPasswordVisible = false
        } label: {
            actionLabel("xmark", "Cancel")
                .background(.red)
        }
    }

    private func actionLabel(_ systemName: String, _ text: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemName)
            Text(text)
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
        .clipShape(Capsule())
    }
}

#Preview {
    UserDetailsView(user: .preview)
}
