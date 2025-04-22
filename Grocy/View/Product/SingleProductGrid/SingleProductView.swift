//
//  SingleProductView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct SingleProductView: View {
    @Bindable var observableProduct: ObservableProduct
    @Bindable var cart: Cart
     var favoriteProducts: Favorite
    
    @State private var isPressed = false
    @State private var addedProductID: UUID?
    
    @State private var showAddedOverlay = false
    
    private var quantityInCart: Int {
        cart.quantity(for: observableProduct)
    }
    
    
    var body: some View {
      
            ZStack(alignment: .topLeading) {
                VStack {
                    ProductImage(imageURL: observableProduct.thumbnail)
                        .frame(width: 100, height: 80)
                        .clipShape(.rect(cornerRadius: 10))
                    ProductInfoView(observableProduct: observableProduct)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    ProductPriceAndCartButtonView(observableProduct: observableProduct, cart: cart, showOverlay: $showAddedOverlay, isPressed: $isPressed)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .scaleEffect(isPressed ? 0.97 : 1.0)
                .opacity(isPressed ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: isPressed)
                .padding(.vertical, 9)
                .padding(.horizontal, 5)
                .overlay(
                    ZStack(alignment: .topTrailing) {
                        if observableProduct.isOffer {
                            OfferRibbon(observableProduct: observableProduct,showText: "", text: "OFFER", font: .system(size: 10), fontWeight: .bold, foregroundColor: .white, backgroundColor: .red, shape: AnyShape(Capsule()), rotation: 0, offsetX: -10, offsetY: +250, shadowRadius: 1.0)
                                .padding(.top, 6)
                                .padding(.leading, 6)
                                .offset(x: +4, y: -180)
                                .zIndex(1)
                               
                        }
                        
                        if quantityInCart > 0 {
                            QuantityBadgeView(quantity: quantityInCart)
                                .transition(.scale)
                                .zIndex(1)
                                .offset(x: -4, y: +2)
                        }
                        AddedOverlayView(added: showAddedOverlay)
                            .offset(x: -4, y: +2)
                    },
                    alignment: .topTrailing
                )
                
                FavoriteButtonView(favoriteProducts: favoriteProducts, observableProduct: observableProduct)
                    .offset(x: +2, y: +2)
                
                
            }
            .frame(width: 120, height: 200)
            .background(.green.opacity(0.09))
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.2, green: 0.5, blue: 0.25), lineWidth: 0.4)
                    .shadow(color: .secondary, radius: 4)
            )
    }
}

#Preview {
    SingleProductView(observableProduct: .example, cart: .example, favoriteProducts: .example)
}
