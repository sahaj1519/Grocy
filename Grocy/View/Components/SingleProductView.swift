//
//  SingleProductView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct SingleProductView: View {
    var product: Product
    @Bindable var cart: Cart
    @Binding var favoriteProducts: Favorite
    
    @State private var isPressed = false
    @State private var addedProductID: UUID?
    
    @State private var showAddedOverlay = false
    
    private var quantityInCart: Int {
        cart.quantity(for: product)
    }
    
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            VStack {
                ProductImage(imageURL: product.thumbnail)
                    .clipped()
                    .frame(minWidth: 150, maxHeight: 150)
                    .clipShape(.rect(cornerRadius: 10))
                ProductInfoView(product: product)
                ProductPriceAndCartButtonView(product: product, cart: cart, showOverlay: $showAddedOverlay, isPressed: $isPressed)
                
            }
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .opacity(isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: isPressed)
            .padding(.vertical, 9)
            .padding(.horizontal, 5)
            .background(.green.opacity(0.09))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.secondary, lineWidth: 0.3)
                    .shadow(color: .secondary, radius: 4)
            )
            .overlay(
                ZStack(alignment: .topTrailing) {
                    if quantityInCart > 0 {
                        QuantityBadgeView(quantity: quantityInCart)
                            .padding(4)
                            .transition(.scale)
                            .zIndex(1)
                            .offset(x: +1.8, y: -3.5)
                    }
                    AddedOverlayView(added: showAddedOverlay)
                },
                alignment: .topTrailing
            )
            
            FavoriteButtonView(favoriteProducts: $favoriteProducts, product: product)
                .offset(x: -1.6, y: +0.21)
            
            
        }
        
        
    }
}

#Preview {
    SingleProductView(product: .example, cart: .example, favoriteProducts: .constant(.example))
}
