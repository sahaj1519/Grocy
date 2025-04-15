//
//  SingleProductView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct SingleProductView: View {
    var product: Product
    @Binding var cart: Cart
    @State private var viewModel = SingleProductViewModel()
    @Binding var favoriteProducts: Favorite
    @State private var showQuantityBadge = false
    @State private var showAddedOverlay = false
    
    private var quantityInCart: Int {
        cart.products.first { $0.id == product.id }?.quantity ?? 0
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ProductImage(imageURL: product.thumbnail)
                    .clipped()
                    .frame(minWidth: 150, maxHeight: 150)
                    .clipShape(.rect(cornerRadius: 10))
                ProductInfoView(product: product)
                ProductPriceAndAddButtonView(product: product) {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.isPressed = true
                    }
                    viewModel.addProductToCart(product: product, cart: cart) { updateCart in
                        cart = updateCart
                        showAddedOverlay = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                showAddedOverlay = false 
                            }
                        }
                        
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        withAnimation {
                            self.showQuantityBadge = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeOut(duration: 0.15)) {
                            viewModel.isPressed = false
                        }
                    }
                }
            }
            .scaleEffect(viewModel.isPressed ? 0.97 : 1.0)
            .opacity(viewModel.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: viewModel.isPressed)
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
                    
                    if quantityInCart > 0 && showQuantityBadge {
                        ZStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 30, height: 30)
                            Text("\(quantityInCart)")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .bold))
                        }
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
    SingleProductView(product: .example, cart: .constant(.example), favoriteProducts: .constant(.example))
}
