//
//  CartDisclosureGroupView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 19/04/25.
//

import SwiftUI

struct CartDisclosureGroupView: View {
    @Bindable var cart: Cart
    
    @State private var activeTooltipID: UUID?
    @State private var isExpanded = false
    
    private let discountID = UUID()
    private let deliveryID = UUID()
    private let gstID = UUID()

    var body: some View {
        Group {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: 12) {
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Total no. of items",
                        value: "\(cart.totalItems)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Price of items",
                        value: "\(cart.convertedTotalPrice)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: discountID,
                        title: "Discount",
                        value: "- ₹\(cart.discount)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .green,
                        showHelp: true,
                        helpMessage: "Discounts from offers or coupons."
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: deliveryID,
                        title: "Delivery Charges",
                        value: "₹\(cart.computedDeliveryCharge)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "No delivery charges on order above ₹599"
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: gstID,
                        title: "GST",
                        value: "₹\(cart.taxAmount)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "GST applied to your order."
                    )
                    
                    Divider()
                    
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Grand Total",
                        value: "\(cart.convertedGrandTotal)",
                        valueFont: .system(size: 12).bold(),
                        valueColor: .primary,
                        showHelp: false,
                        helpMessage: ""
                    )
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } label: {
                LineItemView(
                    activeTooltipID: $activeTooltipID,
                    id: UUID(),
                    title: "Order Total:",
                    value: "\(cart.convertedGrandTotal)",
                    valueFont: .system(size: 14).bold(),
                    valueColor: .primary,
                    showHelp: false,
                    helpMessage: ""
                )
            }
            .tint(.primary)
        }
    }
}

#Preview {
    CartDisclosureGroupView(cart: .example)
}
