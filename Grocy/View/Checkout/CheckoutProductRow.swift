//
//  CheckoutProductRow.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import SwiftUI

struct CheckoutProductRow: View {
    @Bindable var observableProduct: ObservableProduct
    
    var body: some View {
        
        HStack(spacing: 5) {
            ProductImage(imageURL: observableProduct.thumbnail)
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 50, maxHeight: 40, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .accessibilityLabel("Product image: \(observableProduct.name)")
            
            
            Text(observableProduct.name)
                .font(.system(size: 12).bold())
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel("Product: \(observableProduct.name)")
                .accessibilityHint("Name of the product.")
            
            VStack(alignment: .leading) {
                
                if observableProduct.isOffer {
                    if let offer = observableProduct.exclusiveOffer {
                        
                        let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                        let totalQuantity = Int(observableProduct.quantity) * Int(value)
                        let totalPrice = offer.discountedPrice * Decimal(observableProduct.quantity)
                        
                        Text("Quantity: ")
                            .font(.system(size: 12))
                        +
                        Text("\(totalQuantity) \(unit)")
                            .font(.system(size: 12).bold())
                            .accessibilityLabel("Quantity: \(totalQuantity) \(unit)")
                        
                        
                        Text("Price: ")
                            .font(.system(size: 12))
                        +
                        Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                            .font(.system(size: 12).bold())
                            .accessibilityLabel("Price: \(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        
                    }
                } else {
                    
                    let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                    let totalQuantity = Int(observableProduct.quantity) * Int(value)
                    
                    Text("Quantity: ")
                        .font(.system(size: 12))
                    +
                    Text("\(totalQuantity) \(unit)")
                        .font(.system(size: 12).bold())
                        .accessibilityLabel("Quantity: \(totalQuantity) \(unit)")
                    
                    Text("Price: ")
                        .font(.system(size: 12))
                    +
                    Text("\(observableProduct.convertedTotalPrice)")
                        .font(.system(size: 12).bold())
                        .accessibilityLabel("Price: \(observableProduct.convertedTotalPrice)")
                    
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}

#Preview {
    CheckoutProductRow(observableProduct: .example)
}
