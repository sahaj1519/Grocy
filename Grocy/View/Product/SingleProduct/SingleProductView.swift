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
                        .clipped()
                        .frame(minWidth: 130, maxHeight: 100)
                        .clipShape(.rect(cornerRadius: 10))
                    ProductInfoView(observableProduct: observableProduct)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    ProductPriceAndCartButtonView(observableProduct: observableProduct, cart: cart, showOverlay: $showAddedOverlay, isPressed: $isPressed)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                }
                .frame(height: 240)
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
                .frame(minWidth: 170, maxWidth: .infinity)
                .overlay(
                    ZStack(alignment: .topTrailing) {
                        if observableProduct.isOffer {
                            OfferRibbon(observableProduct: observableProduct,showText: "", text: "OFFER", font: .subheadline, fontWeight: .bold, foregroundColor: .white, backgroundColor: .red, shape: AnyShape(Capsule()), rotation: 0, offsetX: -10, offsetY: +270, shadowRadius: 1.0)
                                .padding(.top, 6)
                                .padding(.leading, 6)
                                .offset(x: +4, y: -180)
                                .zIndex(1)
                               
                        }
                        
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
                
                FavoriteButtonView(favoriteProducts: favoriteProducts, observableProduct: observableProduct)
                    .offset(x: -1.2, y: +0.19)
                
                
            }
            
        
    }
}

#Preview {
    SingleProductView(observableProduct: .example, cart: .example, favoriteProducts: .example)
}
