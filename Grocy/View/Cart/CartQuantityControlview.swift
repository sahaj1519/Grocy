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

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    animateChange.insert(product.id)
                    if cartProducts.quantity(for: product) > 1 {
                        cartProducts.updateQuantity(for: product, by: -1)
                    } else {
                        cartProducts.removeProductFromCart(product: product)
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(product.id)
                }
            } label: {
                Image(systemName: "minus")
                    .padding(8.5)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            
           
            Text("\(product.quantity)")
                .font(.headline)
                .frame(minWidth: 40)
                
            
            Button {
                withAnimation {
                    animateChange.insert(product.id)
                    cartProducts.updateQuantity(for: product, by: 1)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(product.id)
                }
            } label: {
                Image(systemName: "plus")
                    .padding(3)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
          
        }
    }
}


#Preview {
    CartQuantityControlview(product: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
