//
//  CartQuantityControlview.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct CartQuantityControlview: View {
    var observableProduct: ObservableProduct
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    animateChange.insert(observableProduct.id)
                    if cartProducts.quantity(for: observableProduct) > 1 {
                        cartProducts.updateQuantity(for: observableProduct, by: -1)
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation {
                                cartProducts.removeProductFromCart(product: observableProduct)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(observableProduct.id)
                }
            } label: {
                Image(systemName: "minus")
                    .padding(8.5)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            
           
            Text("\(observableProduct.quantity)")
                .font(.headline)
                .frame(minWidth: 40)
                
            
            Button {
                withAnimation {
                    animateChange.insert(observableProduct.id)
                    cartProducts.updateQuantity(for: observableProduct, by: 1)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateChange.remove(observableProduct.id)
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
    CartQuantityControlview(observableProduct: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
