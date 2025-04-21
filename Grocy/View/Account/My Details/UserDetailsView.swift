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
        
        if !isEdit {
            Button {
                isEdit = true
            } label: {
                Label("Edit", systemImage: "square.and.pencil")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 2)
                    .padding(.leading, 14)
                    .padding(.trailing, 23)
                    .background(.blue)
                    .clipShape(.capsule)
                    .shadow(color: .blue, radius: 2)
                    .buttonStyle(.borderedProminent)
                
            }
            .padding()
        } else {
            HStack {
                Button {
                   isEdit = false
                } label: {
                    Label("Save", systemImage: "checkmark.circle")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(.vertical, 2)
                        .padding(.leading, 14)
                        .padding(.trailing, 23)
                        .background(.green)
                        .clipShape(.capsule)
                        .buttonStyle(.borderedProminent)
                    
                }
                .padding()
                
                Button {
                    Task { @MainActor in
                        
                       isEdit = false
                        try await user.saveUserData()
                        
                    }
                } label: {
                    Label("Cancel", systemImage: "xmark.circle")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(.vertical, 1.5)
                        .padding(.leading, 13)
                        .padding(.trailing, 20)
                        .background(.red)
                        .clipShape(.capsule)
                        .buttonStyle(.borderedProminent)
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    UserDetailsView(user: .preview)
}
