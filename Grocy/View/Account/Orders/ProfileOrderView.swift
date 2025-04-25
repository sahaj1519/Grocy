//
//  ProfileOrderView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct ProfileOrderView: View {
    @Bindable var user: DataModel
    @State private var activeTooltipID = false
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if user.currentUser.sortedOrdersByDate.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Label("No Orders Yet", systemImage: "cart")
                                .accessibilityLabel("No orders available.")
                        },
                        description: {
                            Text("When you place orders, they’ll show up here.")
                                .accessibilityLabel("When you place orders, they’ll show up here.")
                        },
                        actions: {
                            Button("Start Shopping") {
                                selectedTab = .shop
                            }
                            .buttonStyle(.borderedProminent)
                            .accessibilityLabel("Start shopping")
                            .accessibilityHint("Tap to begin shopping")
                        }
                    )
                    .padding()
                    
                } else {
                    
                    ForEach(user.currentUser.sortedOrdersByDate) { order in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Order Date: \(order.convertedDate)")
                                .font(.system(size: 12).bold())
                                .foregroundStyle(.secondary)
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityLabel("Order Date")
                                .accessibilityValue(order.convertedDate)
                            ForEach(order.observableProducts) { product in
                                HStack(spacing: 5) {
                                    ProductImage(imageURL: product.thumbnail)
                                        .clipped()
                                        .frame(width: 60, height: 30, alignment: .leading)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .frame(maxWidth: 70, alignment: .leading)
                                        .accessibilityLabel("Product Image")
                                    
                                    
                                    Text(product.name)
                                        .font(.system(size: 12).bold())
                                        .lineLimit(3)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .accessibilityLabel("Product Name")
                                        .accessibilityValue(product.name)
                                    
                                    OrderRows(observableProduct: product)
                                    
                                }
                            }
                            HStack {
                                OrderDisclosureGroup(order: order)
                                    .padding(.trailing)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        .padding()
                        .background(.secondary.opacity(0.1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contextMenu {
                            Button("Delete Order", role: .destructive) {
                                Task { @MainActor in
                                    user.removeOrder(order)
                                    try await user.saveUserData()
                                }
                            }
                            .accessibilityLabel("Delete Order")
                            .accessibilityHint("Tap to delete this order.")
                        }
                    }
                    .navigationTitle("Orders History")
                }
            }
        }
    }
}

#Preview {
    ProfileOrderView(user: .preview, selectedTab: .constant(.account))
}
