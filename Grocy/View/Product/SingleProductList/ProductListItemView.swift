//
//  ProductListItemView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 22/04/25.
//

import SwiftUI

struct ProductListItemView: View {
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
        HStack(alignment: .top, spacing: 12) {
            ProductImage(imageURL: observableProduct.thumbnail)
                .frame(width: 80, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {
                Text(observableProduct.name)
                    .font(.subheadline.bold())
                    .lineLimit(2)

                if observableProduct.isOffer, let offer = observableProduct.exclusiveOffer {
                    Text("\(observableProduct.convertedPrice) / \(observableProduct.unit)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .strikethrough()

                    Text("\(offer.convertedDiscountedPrice) / \(observableProduct.unit)")
                        .font(.caption2.bold())
                } else {
                    Text("\(observableProduct.convertedPrice) / \(observableProduct.unit)")
                        .font(.caption2.bold())
                        .foregroundStyle(.primary)
                }

                if isAlreadyInCart {
                    HStack(spacing: 10) {
                        Button {
                            if cart.quantity(for: observableProduct) > 1 {
                                cart.updateQuantity(for: observableProduct, by: -1)
                            } else {
                                cart.removeProductFromCart(product: observableProduct)
                            }
                        } label: {
                            Image(systemName: "minus")
                                .font(.caption)
                                .padding(6)
                                .background(.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }

                        Text("\(cart.quantity(for: observableProduct))")
                            .font(.caption.bold())
                            .frame(width: 24)

                        Button {
                            cart.updateQuantity(for: observableProduct, by: 1)
                        } label: {
                            Image(systemName: "plus")
                                .font(.caption)
                                .padding(4)
                                .background(.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                } else {
                    Button(action: handleAddToCart) {
                        Label("Add to Cart", systemImage: "cart.badge.plus")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProductListItemView(
        observableProduct: .example,
        cart: .example,
        showOverlay: .constant(false),
        isPressed: .constant(false)
    )
}
