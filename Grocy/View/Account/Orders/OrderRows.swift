//
//  OrderRows.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import SwiftUI

struct OrderRows: View {
    @Bindable var observableProduct: ObservableProduct
    var body: some View {
        VStack(alignment: .leading) {
            
            if observableProduct.isOffer {
                if let offer = observableProduct.exclusiveOffer {
                    
                    let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                    let totalQuantity = Int(observableProduct.quantity) * Int(value)
                    let totalPrice = offer.discountedPrice * Decimal(observableProduct.quantity)
                    
                    HStack {
                        Text("Quantity: ")
                            .font(.system(size: 10))
                            .accessibilityLabel("Quantity")
                        Text("\(totalQuantity) \(unit)")
                            .font(.system(size: 10).bold())
                            .accessibilityValue("\(totalQuantity), \(unit)")
                    }
                    
                    HStack {
                        Text("Price: ")
                            .font(.system(size: 10))
                            .accessibilityLabel("Price")
                        Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                            .font(.system(size: 10).bold())
                            .accessibilityValue("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    }
                }
            } else {
                
                let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                let totalQuantity = Int(observableProduct.quantity) * Int(value)
                
                HStack {
                    Text("Quantity: ")
                        .font(.system(size: 10))
                        .accessibilityLabel("Quantity")
                    Text("\(totalQuantity) \(unit)")
                        .font(.system(size: 10).bold())
                        .accessibilityValue("\(totalQuantity) \(unit)")
                }
                
                HStack {
                    Text("Price: ")
                        .font(.system(size: 10))
                        .accessibilityLabel("Price")
                    Text("\(observableProduct.convertedTotalPrice)")
                        .font(.system(size: 10).bold())
                        .accessibilityValue("\(observableProduct.convertedTotalPrice)")
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    OrderRows(observableProduct: .example)
}
