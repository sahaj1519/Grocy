//
//  InputField.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import SwiftUI

struct InputField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var accessibilityID: String? = nil
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TextField(placeholder, text: $text)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .textContentType(placeholder == "Email" ? .emailAddress : placeholder == "Phone" ? .telephoneNumber : .name)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 1))
            .accessibilityIdentifier(accessibilityID ?? placeholder)
    }
}

#Preview {
    InputField(placeholder: "placeholder", text: .constant("text"), keyboardType: .decimalPad)
}
