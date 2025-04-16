//
//  CartFooterView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct CartFooter: View {
    var totalPrice: Decimal
    
    var body: some View {
        VStack {
            Spacer()
            if totalPrice > 0 {
                HStack {
                    Text(" \(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .font(.title.bold())
                        .foregroundColor(.green)
                        .padding(.top, 10)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.3), value: totalPrice) 
                    
                    Spacer()
                    
                    NavigationLink(destination: CheckoutView.init) {
                        Label("Checkout", systemImage: "creditcard")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .clipShape(Capsule())
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: totalPrice)
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    CartFooter(totalPrice: 20)
}
