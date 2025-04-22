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
                .clipped()
                .frame(width: 70, height: 40, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .frame(maxWidth: 70, alignment: .leading)
            

                Text(observableProduct.name)
                .font(.system(size: 12).bold())
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .leading)

            
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
                        
                        
                        Text("Price: ")
                            .font(.system(size: 12))
                        +
                        Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                            .font(.system(size: 12).bold())
                            
                    }
                } else {
                    
                    let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                    let totalQuantity = Int(observableProduct.quantity) * Int(value)
                   
                    Text("Quantity: ")
                        .font(.system(size: 12))
                    +
                    Text("\(totalQuantity) \(unit)")
                        .font(.system(size: 12).bold())
                    
                    Text("Price: ")
                        .font(.system(size: 12))
                    +
                    Text("\(observableProduct.convertedTotalPrice)")
                        .font(.system(size: 12).bold())
                        
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        //.padding(.vertical, 6)
    }
}

#Preview {
    CheckoutProductRow(observableProduct: .example)
}
