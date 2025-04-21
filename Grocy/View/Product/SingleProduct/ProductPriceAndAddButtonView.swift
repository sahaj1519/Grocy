//
//  ProductPriceAndAddButtonView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductPriceAndCartButtonView: View {
    @Bindable var observableProduct: ObservableProduct
    @Bindable var cart: Cart
    @Binding var showOverlay: Bool
    @Binding var isPressed: Bool
   
    
    var isAlreadyInCart: Bool {
        cart.observableProducts.contains(where: { $0.id == observableProduct.id })
    }


    private func handleAddToCart() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()

        withAnimation(.easeInOut(duration: 0.15)) {
            isPressed = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            cart.addToCart(product: observableProduct)
            showOverlay = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    showOverlay = false
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeOut(duration: 0.2)) {
                isPressed = false
            }
        }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if observableProduct.isOffer {
                if let offer = observableProduct.exclusiveOffer {
                    Text("\(observableProduct.convertedPrice) / \(observableProduct.unit)")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .strikethrough()
                      //  .frame(width: .infinity)
                        
                    Text("\(offer.convertedDiscountedPrice) / \(observableProduct.unit)")
                        .font(.subheadline.bold())
                        .lineLimit(1)
                       // .frame(width: .infinity)
                }
                
            } else {
                Text("\(observableProduct.convertedPrice) / \(observableProduct.unit)")
                    .font(.subheadline.bold())
                    .lineLimit(1)
                    //.frame(width: .infinity)
            }
            if isAlreadyInCart {
                HStack {
                    Button {
                        if cart.quantity(for: observableProduct) > 1 {
                            cart.updateQuantity(for: observableProduct, by: -1)
                        } else {
                            cart.removeProductFromCart(product: observableProduct)
                        }
                    } label: {
                        Image(systemName: "minus")
                            .padding(12)
                            .background(.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    
                    
                    Text("\(cart.quantity(for: observableProduct))")
                        .font(.headline)
                        .frame(minWidth: 30)
                    
                    Button {
                        cart.updateQuantity(for: observableProduct, by: 1)
                    }label: {
                        Image(systemName: "plus")
                            .padding(6)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                   
                   
                }
            } else {
                HStack {
                    Button(action: handleAddToCart) {
                        Label("Add", systemImage: "cart.badge.plus")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 2)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                }
                
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 1)
    }
}


#Preview {
    ProductPriceAndCartButtonView(
        observableProduct: .example,
        cart: .example,
        showOverlay: .constant(true),
        isPressed: .constant(true)
    )
}
