//
//  ProductPriceAndAddButtonView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductPriceAndCartButtonView: View {
    var product: Product
    @Bindable var cart: Cart
    @Binding var showOverlay: Bool
    @Binding var isPressed: Bool

    private func handleAddToCart() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()

        withAnimation(.easeInOut(duration: 0.15)) {
            isPressed = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            cart.addToCart(product: product)
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
        HStack {
            Text("\(product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .font(.headline.bold())

            Spacer()

            Button(action: handleAddToCart) {
                Image(systemName: "plus")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(.green)
                    .clipShape(.rect(cornerRadius: 8))
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


#Preview {
    ProductPriceAndCartButtonView(
        product: .example,
        cart: .example,
        showOverlay: .constant(true),
        isPressed: .constant(true)
    )
}
