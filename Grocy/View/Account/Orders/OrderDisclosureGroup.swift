//
//  OrderDisclosureGroup.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct OrderDisclosureGroup: View {
    var order: Order
    
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
                        value: "\(order.totalItems)",
                        valueFont: .system(size: 10),
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    .accessibilityLabel("Total number of items")
                    .accessibilityValue("\(order.totalItems)")
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Price of items",
                        value: "\(order.convertedTotalPrice)",
                        valueFont: .system(size: 10),
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    .accessibilityLabel("Price of items")
                    .accessibilityValue("\(order.convertedTotalPrice)")
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: discountID,
                        title: "Discount",
                        value: "- ₹\(order.discount)",
                        valueFont: .system(size: 10),
                        valueColor: .green,
                        showHelp: true,
                        helpMessage: "Discounts from offers or coupons."
                    )
                    .accessibilityLabel("Discount")
                    .accessibilityValue("- ₹\(order.discount)")
                    
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: deliveryID,
                        title: "Delivery Charges",
                        value: "₹\(order.computedDeliveryCharge)",
                        valueFont: .system(size: 10),
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "No delivery charges on order above ₹599"
                    )
                    .accessibilityLabel("Delivery Charges")
                    .accessibilityValue("₹\(order.computedDeliveryCharge)")
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: gstID,
                        title: "GST",
                        value: "₹\(order.taxAmount)",
                        valueFont: .system(size: 10),
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "GST applied to your order."
                    )
                    .accessibilityLabel("GST")
                    .accessibilityValue("₹\(order.taxAmount)")
                    
                    Divider()
                    
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Grand Total",
                        value: "\(order.convertedGrandTotal)",
                        valueFont: .system(size: 13).bold(),
                        valueColor: .primary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    .accessibilityLabel("Grand Total")
                    .accessibilityValue("\(order.convertedGrandTotal)")
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } label: {
                LineItemView(
                    activeTooltipID: $activeTooltipID,
                    id: UUID(),
                    title: "Total Paid:",
                    value: "\(order.convertedGrandTotal)",
                    valueFont: .system(size: 13).bold(),
                    valueColor: .secondary,
                    showHelp: false,
                    helpMessage: ""
                )
                .accessibilityLabel("Total Paid")
                .accessibilityValue("\(order.convertedGrandTotal)")
            }
            .tint(.primary)
        }
    }
}

#Preview {
    OrderDisclosureGroup(order: .example)
}
