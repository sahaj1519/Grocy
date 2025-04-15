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
    @Binding var cartProducts: Cart
    
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
                HStack {
                    Button(action: {
                        withAnimation {
                            animateChange.insert(product.id)
                            if product.quantity > 1 {
                                updateQuantity(for: product, by: -1)
                            } else {
                                removeProductFromCart(product: product)
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            animateChange.remove(product.id)
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                    }
                    
                    Text("\(product.unit) x ")
                        .font(.subheadline.bold())
                        
                    +
                    Text("\(product.quantity)")
                        .fontWeight(.bold)
                        
                    
                    Button(action: {
                        withAnimation {
                            animateChange.insert(product.id)
                            updateQuantity(for: product, by: 1)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            animateChange.remove(product.id)
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                }
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
    CartProductRow(product: .example, animateChange: .constant([UUID()]), cartProducts: .constant(.example))
}
