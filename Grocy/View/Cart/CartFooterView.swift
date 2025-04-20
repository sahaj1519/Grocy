//
//  CartFooterView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct CartFooter: View {
    var totalPrice: Decimal
    @Bindable var user: DataModel
    @Bindable var cart: Cart
    
    var body: some View {
        VStack {
            HStack(spacing: 1) {
                Text("Total: ")
                    .font(.title.bold())
                    .lineLimit(1)
                
                Text(" \(cart.convertedTotalPrice)")
                    .font(.title.bold())
                    .foregroundColor(.green)
                    .frame(minWidth: 70)
                    .animation(.easeInOut(duration: 0.3), value: totalPrice)
                    
            }
            .padding()
           
            
            NavigationLink(destination: CheckoutView(user: user, cart: cart)) {
                Label("Checkout", systemImage: "creditcard")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .clipShape(Capsule())
            }
            
            .disabled(totalPrice <= 0)
        
        }
        .opacity(totalPrice > 0 ? 1 : 0)
        
    }
}

#Preview {
    CartFooter(totalPrice: 20, user: DataModel(), cart: .example)
}
