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
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            TextField("Name", text: $user.currentUser.name)
                .padding(5)
                .background(isEdit ? Color.white : Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEdit ? Color.green : Color.clear, lineWidth: 1)
                )
                .textContentType(.name)
            
            TextField("Email", text: $user.currentUser.email)
                .padding(5)
                .background(isEdit ? Color.white : Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEdit ? Color.green : Color.clear, lineWidth: 1)
                )
                .textContentType(.emailAddress)
            
            TextField("Phone Number", text: $user.currentUser.phone)
                .padding(5)
                .background(isEdit ? Color.white : Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEdit ? Color.green : Color.clear, lineWidth: 1)
                )
                .textContentType(.telephoneNumber)
            
            
            Text("Please enter a valid 10-digit phone number.")
                .foregroundColor(.red)
                .font(.footnote)
                .opacity(!user.currentUser.isValidPhoneNumber && isEdit ? 1 : 0)
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .disabled(!isEdit)
        
        VStack {
            
            if !isEdit {
                Button {
                    isEdit = true
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 16)
                    .background(.blue)
                    .clipShape(Capsule())
                }
                .padding(.top, 10)
            } else {
                HStack(spacing: 12) {
                    Button {
                        Task { @MainActor in
                            try await user.saveUserData()
                            isEdit = false
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark")
                            Text("Save")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(.green)
                        .clipShape(Capsule())
                    }
                    
                    Button {
                        isEdit = false
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark")
                            Text("Cancel")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(.red)
                        .clipShape(Capsule())
                    }
                }
                .padding(.top, 10)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    UserDetailsView(user: .preview)
}
