//
//  CartQuantityControlview.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct CartQuantityControlview: View {
    var observableProduct: ObservableProduct
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart

    var body: some View {
        HStack {
            quantityButton(systemName: "minus", color: .red) {
                animateChange.insert(observableProduct.id)
                if cartProducts.quantity(for: observableProduct) > 1 {
                    cartProducts.updateQuantity(for: observableProduct, by: -1)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation {
                            cartProducts.removeProductFromCart(product: observableProduct)
                        }
                    }
                }
                removeAnimationDelay()
            }
            .accessibilityLabel("Decrease quantity")
            .accessibilityHint("Decreases quantity of \(observableProduct.name)")


            Text("\(observableProduct.quantity)")
                .font(.subheadline.bold())
                .frame(minWidth: 40)
                .accessibilityLabel("Quantity")
                .accessibilityValue("\(observableProduct.quantity)")

            quantityButton(systemName: "plus", color: .green) {
                animateChange.insert(observableProduct.id)
                cartProducts.updateQuantity(for: observableProduct, by: 1)
                removeAnimationDelay()
            }
            .accessibilityLabel("Increase quantity")
            .accessibilityHint("Increases quantity of \(observableProduct.name)")
        }
    }

    private func quantityButton(systemName: String, color: Color, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: systemName)
                .font(.caption2)
                .padding(systemName == "plus" ? 3.3 : 7)
                .background(color)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }

    private func removeAnimationDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            animateChange.remove(observableProduct.id)
        }
    }
}

#Preview {
    CartQuantityControlview(observableProduct: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
