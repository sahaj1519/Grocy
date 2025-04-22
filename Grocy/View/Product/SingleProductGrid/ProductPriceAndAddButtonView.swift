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
                        .font(.system(size: 10).bold())
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .strikethrough()
                   
                        
                    Text("\(offer.convertedDiscountedPrice) / \(observableProduct.unit)")
                        .font(.system(size: 10).bold())
                        .lineLimit(2)
                      
                }
                
            } else {
                Text("\(observableProduct.convertedPrice) / \(observableProduct.unit)")
                    .font(.system(size: 10).bold())
                    .lineLimit(2)
                   
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
                            .font(.caption)
                            .padding(8)
                            .background(.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    
                    
                    Text("\(cart.quantity(for: observableProduct))")
                        .font(.caption)
                        .frame(width: 15)
                    
                    Button {
                        cart.updateQuantity(for: observableProduct, by: 1)
                    }label: {
                        Image(systemName: "plus")
                            .font(.caption2)
                            .padding(4)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                   
                   
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                HStack {
                    Button(action: handleAddToCart) {
                        Label("Add", systemImage: "cart.badge.plus")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 2)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
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
