//
//  PaymentMethodsView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import SwiftUI

struct PaymentMethodsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ContentUnavailableView(
                    "No payment methods available",
                    systemImage: "creditcard",
                    description: Text("No payment methods added yet. Tap the button below to add one.")
                        .accessibilityLabel("No payment methods available. Tap the button to add a payment method.")
                )
                .accessibilityElement(children: .combine)
                
                Button {
                    // Add payment method action
                } label: {
                    Label("Add Payment Method", systemImage: "creditcard")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .accessibilityLabel("Add Payment Method Button")
                        .accessibilityHint("Tap to add a new payment method")
                }
                .padding(.horizontal)
            }
            .navigationTitle("Payment Methods")
            .padding()
        }
        
    }
}

#Preview {
    PaymentMethodsView()
}
