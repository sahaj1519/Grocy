//
//  CartProductRowView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//
import SwiftUI

struct CartProductRow: View {
    var product: Product
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart
    
    func updateQuantity(for product: Product, by amount: Int) {
        if let index = cartProducts.products.firstIndex(where: { $0.id == product.id }) {
            cartProducts.products[index].quantity += amount
        }
    }
    
    func removeProductFromCart(product: Product) {
        if let index = cartProducts.products.firstIndex(where: { $0.id == product.id }) {
            cartProducts.products.remove(at: index)
        }
    }

    var body: some View {
        HStack {
            ProductImage(imageURL: product.thumbnail)
                .frame(width: 150, height: 100)
                .clipShape(.rect(cornerRadius: 10))
            Spacer()
            VStack {
                Text(product.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text("\(product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))/ \(product.unit)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                
                Spacer()
                CartQuantityControlview(product: product, animateChange: $animateChange, cartProducts: cartProducts)
            }
            .padding(.leading, 10)
            Spacer()
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.green.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .scaleEffect(animateChange.contains(product.id) ? 1.05 : 1.0)
        .opacity(animateChange.contains(product.id) ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: animateChange)
    }
}

#Preview {
    CartProductRow(product: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
