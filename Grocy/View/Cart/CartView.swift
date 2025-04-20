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
                if cartProducts.products.isEmpty {
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
                        ForEach(cartProducts.products, id: \.id) { product in
                            
                            CartProductRow(product: product, animateChange: $animateChange, cartProducts: cartProducts)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing).combined(with: .opacity),
                                    removal: .move(edge: .leading).combined(with: .opacity)
                                ))
                                .padding(.bottom, 6)
                                .id(product.id)
                            Divider()
                        }
                        Spacer()
                            .frame(height: 100)
                    }
                    .padding(.horizontal)
                    .animation(.easeInOut(duration: 0.3), value: cartProducts.products)
                    
                    Spacer(minLength: 30)
                }
                    CartFooter(totalPrice: cartProducts.totalPrice(), user: user, cart: cartProducts)
                        .padding(.vertical)
                    
                }
                .frame(minHeight: UIScreen.main.bounds.height - 170)
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(.green.opacity(0.05))
           
            
        }
    }
}

#Preview {
    CartView(cartProducts: Cart.loadFromUserDefaults() ?? .example, user: .preview)

}
