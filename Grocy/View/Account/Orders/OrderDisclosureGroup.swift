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
                        valueFont: .subheadline,
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Price of items",
                        value: "\(order.convertedTotalPrice)",
                        valueFont: .subheadline,
                        valueColor: .secondary,
                        showHelp: false,
                        helpMessage: ""
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: discountID,
                        title: "Discount",
                        value: "- ₹\(order.discount)",
                        valueFont: .subheadline,
                        valueColor: .green,
                        showHelp: true,
                        helpMessage: "Discounts from offers or coupons."
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: deliveryID,
                        title: "Delivery Charges",
                        value: "₹\(order.computedDeliveryCharge)",
                        valueFont: .subheadline,
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "No delivery charges on order above ₹599"
                    )
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: gstID,
                        title: "GST",
                        value: "₹\(order.taxAmount)",
                        valueFont: .subheadline,
                        valueColor: .secondary,
                        showHelp: true,
                        helpMessage: "18% GST applied to your order."
                    )
                    
                    Divider()
                    
                    LineItemView(
                        activeTooltipID: $activeTooltipID,
                        id: UUID(),
                        title: "Grand Total",
                        value: "\(order.convertedGrandTotal)",
                        valueFont: .headline.bold(),
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
                    title: "Total Paid:",
                    value: "\(order.convertedGrandTotal)",
                    valueFont: .headline.bold(),
                    valueColor: .secondary,
                    showHelp: false,
                    helpMessage: ""
                )
            }
            .tint(.primary)
        }
    }
}

#Preview {
    OrderDisclosureGroup(order: .example)
}
