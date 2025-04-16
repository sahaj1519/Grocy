//
//  CartView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct CartView: View {
    @Bindable var cartProducts: Cart
    @State private var animateChange: Set<UUID> = []

    func totalPrice() -> Decimal {
        return cartProducts.products.reduce(0) { $0 + ($1.price * Decimal($1.quantity)) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        if cartProducts.products.isEmpty {
                            ContentUnavailableView(
                                "Your Cart is Empty",
                                systemImage: "cart",
                                description: Text("Browse products and tap “Add to Cart” to get started.")
                            )
                            .padding(.top, 100)
                            .multilineTextAlignment(.center)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                            
                        } else {
                            Text("Your Cart")
                                .font(.largeTitle.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            ForEach(cartProducts.products, id: \.id) { product in
                                CartProductRow(product: product, animateChange: $animateChange, cartProducts: cartProducts)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)
                                    ))
                                    .padding(.bottom, 6)
                                    .id(product.id)
                                
                            }
                            
                        }
                    }
                    .padding()
                    .animation(.easeInOut(duration: 0.3), value: cartProducts.products)
                }
                .scrollBounceBehavior(.basedOnSize)
                
                CartFooter(totalPrice: totalPrice())
                    .padding(.vertical)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CartView(cartProducts: .example)
}
