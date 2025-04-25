//
//  ErrorMessageView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//

import SwiftUI

struct ErrorMessageView: View {
    var message: String?
    
    var body: some View {
        if let message = message {
            Text(message)
                .foregroundColor(.red)
                .font(.subheadline)
                .transition(.opacity)
                .accessibilityLabel("Error message: \(message)")
        }
    }
}


#Preview {
    ErrorMessageView()
}
