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
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textContentType(placeholder == "Email" ? .emailAddress : .name)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 1))
    }
}

#Preview {
    InputField(placeholder: "placeholder", text: .constant("text"), keyboardType: .decimalPad)
}
