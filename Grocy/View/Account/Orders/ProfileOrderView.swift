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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(user.currentUser.orders) { order in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Order Date: \(order.convertedDate)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(order.products) { product in
                            HStack(spacing: 5) {
                                ProductImage(imageURL: product.thumbnail)
                                    .clipped()
                                    .frame(width: 50, height: 40, alignment: .leading)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .frame(maxWidth: 70, alignment: .leading)
                                
                                
                                Text(product.name)
                                    .font(.headline)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    if product.isOffer {
                                        if let offer = product.exclusiveOffer {
                                            
                                            let (value, unit) = product.parsedUnit ?? (1, "unit")
                                            let totalQuantity = Int(product.quantity) * Int(value)
                                            let totalPrice = offer.discountedPrice * Decimal(product.quantity)
                                            
                                            Text("Quantity: ")
                                                .font(.subheadline)
                                            +
                                            Text("\(totalQuantity) \(unit)")
                                                .font(.headline.bold())
                                            
                                            
                                            Text("Price: ")
                                                .font(.subheadline)
                                            +
                                            Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                                .fontWeight(.bold)
                                            
                                        }
                                    } else {
                                        
                                        let (value, unit) = product.parsedUnit ?? (1, "unit")
                                        let totalQuantity = Int(product.quantity) * Int(value)
                                        
                                        Text("Quantity: ")
                                            .font(.subheadline)
                                        +
                                        Text("\(totalQuantity) \(unit)")
                                            .font(.headline.bold())
                                        
                                        Text("Price: ")
                                            .font(.subheadline)
                                        +
                                        Text("\(product.convertedTotalPrice)")
                                            .fontWeight(.bold)
                                        
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
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
                }
                .navigationTitle("Orders History")
            }
           
        }
    }
}

#Preview {
    ProfileOrderView(user: .preview)
}
