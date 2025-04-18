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
            HStack(spacing: 1) {
                Text("Total: ")
                    .font(.title.bold())
                    .lineLimit(1)
                
                Text(" \(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title.bold())
                    .foregroundColor(.green)
                    .frame(minWidth: 70)
                    .animation(.easeInOut(duration: 0.3), value: totalPrice)
                    
            }
            .padding()
           
            
            NavigationLink(destination: CheckoutView.init) {
                Label("Checkout", systemImage: "creditcard")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .clipShape(Capsule())
            }
            
            .disabled(totalPrice <= 0)
            .animation(.easeInOut(duration: 0.3), value: totalPrice)
        }
        .opacity(totalPrice > 0 ? 1 : 0)
        
    }
}

#Preview {
    CartFooter(totalPrice: 20)
}
