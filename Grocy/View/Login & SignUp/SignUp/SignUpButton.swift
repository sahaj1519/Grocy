//
//  SignUpButton.swift
//  Grocy
//
//  Created by Ajay Sangwan on 24/04/25.
//
import SwiftUI

struct SignUpButton: View {
   
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Sign Up")
                .font(.title2).fontWeight(.bold).foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.green)
                .cornerRadius(15)
                .shadow(radius: 2)
        }
        .padding(.top)
        .accessibilityIdentifier("SignUp_Button")
       
    }
}

#Preview {
    SignUpButton(action: { })
}
