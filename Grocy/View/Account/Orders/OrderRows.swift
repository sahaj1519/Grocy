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
                    
                    Text("Quantity: ")
                        .font(.system(size: 10))
                    +
                    Text("\(totalQuantity) \(unit)")
                        .font(.system(size: 10).bold())
                    
                    
                    Text("Price: ")
                        .font(.system(size: 10))
                    +
                    Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .font(.system(size: 10).bold())
                    
                }
            } else {
                
                let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                let totalQuantity = Int(observableProduct.quantity) * Int(value)
                
                Text("Quantity: ")
                    .font(.system(size: 10))
                +
                Text("\(totalQuantity) \(unit)")
                    .font(.system(size: 10).bold())
                
                Text("Price: ")
                    .font(.system(size: 10))
                +
                Text("\(observableProduct.convertedTotalPrice)")
                    .font(.system(size: 10).bold())
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    OrderRows(observableProduct: .example)
}
