//
//  CartView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct CartView: View {
    @Bindable var cartProducts: Cart
    @Bindable var user: DataModel
    @State private var animateChange: Set<UUID> = []
   
    var body: some View {
        NavigationStack {
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if cartProducts.observableProducts.isEmpty {
                        ContentUnavailableView(
                            "Your Cart is Empty",
                            systemImage: "cart",
                            description: Text("Browse products and tap “Add to Cart” to get started.")
                        )
                        .padding(.top, 100)
                        .multilineTextAlignment(.center)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .frame(maxHeight: .infinity)
                    } else {
                        Text("My Cart")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Divider()
                        LazyVStack {
                            ForEach(cartProducts.observableProducts, id: \.id) { product in
                                
                                CartProductRow(observableProduct: product, animateChange: $animateChange, cartProducts: cartProducts)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)
                                    ))
                                    .padding(.bottom, 6)
                                    .id(product.id)
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 100)
                        .animation(.easeInOut(duration: 0.3), value: cartProducts.observableProducts)
                       
                        
                    }
                    
                }
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(.green.opacity(0.05))
            .safeAreaInset(edge: .bottom) {
                    CartFooter(totalPrice: cartProducts.totalPrice(), user: user, cart: cartProducts)
                        .background(.ultraThinMaterial)
                        .opacity(cartProducts.totalPrice() > 0 ? 1 : 0)
                        
                }
            
        }
    }
}

#Preview {
    CartView(cartProducts: Cart.loadFromUserDefaults() ?? .example, user: .preview)

}
