//
//  CartFooterView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct CartFooter: View {
    var totalPrice: Decimal
    @Bindable var user: DataModel
    @Bindable var cart: Cart
    @State private var showDetails = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            DisclosureGroup(isExpanded: $showDetails) {
                VStack(spacing: 4) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text(cart.convertedTotalPrice)
                            .bold()
                    }
                    
                    HStack {
                        Text("Delivery")
                        Spacer()
                        Text("₹\(cart.computedDeliveryCharge)")
                            .foregroundColor(cart.computedDeliveryCharge == 0 ? .green : .primary)
                    }
                    
                    if cart.computedDeliveryCharge > 0 {
                        Text("Free delivery above ₹599")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider()
                }
                .font(.caption)
                .padding(.top, 4)
            } label: {
                HStack {
                    Text("Total Payable")
                        .font(.subheadline.bold())
                    Spacer()
                    Text(cart.deliveryChargesPlusSubtotal)
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            .tint(.primary)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Price details")
            .accessibilityHint("Tap to expand or collapse subtotal and delivery information")
            
            NavigationLink(destination: CheckoutView(user: user, cart: cart)) {
                Label("Checkout", systemImage: "creditcard")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            .disabled(totalPrice <= 0)
            .accessibilityLabel("Proceed to checkout")
            .accessibilityHint("Navigates to payment and order details screen")
        }
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .opacity(totalPrice > 0 ? 1 : 0)
    }
}

#Preview {
    CartFooter(totalPrice: 20, user: DataModel(), cart: .example)
}
