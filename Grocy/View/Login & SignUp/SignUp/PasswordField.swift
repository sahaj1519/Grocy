//
//  PasswordField.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import SwiftUI

struct PasswordField: View {
    @Binding var isPasswordVisible: Bool
    @Binding var password: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Group {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                       
                } else {
                    SecureField("Password", text: $password)
                      
                }
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .textContentType(.password)
            .autocapitalization(.none)
            Button { isPasswordVisible.toggle() } label: {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .accessibilityIdentifier("SignUp_PasswordField")
    }
}

#Preview {
    PasswordField(isPasswordVisible: .constant(true), password: .constant("password"))
}
