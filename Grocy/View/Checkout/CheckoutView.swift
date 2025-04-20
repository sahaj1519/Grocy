//
//  CheckoutView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var user: DataModel
    @Bindable var cart: Cart
    @FocusState  var focusedField: Field?
    
    @State private var isShowOrderPlaced = false
   
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    ForEach(cart.products) {product in
                        CheckoutProductRow(product: product)
                    }
                    
                }header: {
                    Text("Products Summary")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                
                CheckoutDetailsFormView(user: user, focusedField: $focusedField)
                
                Section {
                    
                    CartDisclosureGroupView(cart: cart)
                    
                    HStack {
                        Spacer()
                        Button("Place Order") {
                            isShowOrderPlaced = true
                            Task { @MainActor in
                                let order = Order(date: .now, isCompleted: true, products: cart.products)
                                user.currentUser.orders.append(order)
                                
                                Cart.clearFromUserDefaults()
                                cart.products.removeAll()
                                
                                try await user.saveUserData()
                            }
                        }
                        .padding(.horizontal)
                        .disabled(!user.currentUser.canPlaceOrder)
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .clipShape(Capsule())
                    
                    Link(destination: URL(string: "https://yourtermslink.com")!) {
                        Text("By placing an order you agree to our ")
                        + Text("Terms").bold().underline()
                        + Text(" and ")
                        + Text("Conditions").bold().underline()
                    }
                    .tint(.primary)
                    .font(.caption)
                }
                
                
            }
            .navigationTitle("Checkout Details")
            .navigationBarTitleDisplayMode(.inline)
            .background(.green.opacity(0.05))
            .navigationDestination(isPresented: $isShowOrderPlaced) {
                OrderPlacedView()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    CheckoutView(user: .preview, cart: .example)
}
