//
//  CartQuantityControlview.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct CartQuantityControlview: View {
    var product: Product
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart

    func updateQuantity(for product: Product, by amount: Int) {
        if let index = cartProducts.products.firstIndex(where: { $0.id == product.id }) {
            cartProducts.products[index].quantity += amount
        }
    }
    
    func removeProductFromCart(product: Product) {
        if let index = cartProducts.products.firstIndex(where: { $0.id == product.id }) {
            cartProducts.products.remove(at: index)
        }
    }

    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    animateChange.insert(product.id)
                    if product.quantity > 1 {
                        updateQuantity(for: product, by: -1)
                    } else {
                        removeProductFromCart(product: product)
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(product.id)
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
                    .font(.title3)
            }
            
            Text("\(product.unit) x ")
                .font(.subheadline.bold())
            
            +
            Text("\(product.quantity)")
                .fontWeight(.bold)
            
            Button(action: {
                withAnimation {
                    animateChange.insert(product.id)
                    updateQuantity(for: product, by: 1)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(product.id)
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
    }
}


#Preview {
    CartQuantityControlview(product: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
