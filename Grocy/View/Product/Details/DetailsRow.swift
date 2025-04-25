//
//  DetailsRow.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import SwiftUI

struct DetailsRow: View {
    @Binding var animateDetails: Bool
    @Bindable var observableProduct: ObservableProduct
    var body: some View {
        Text("Description: ")
            .font(.subheadline.bold())
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
            .accessibilityLabel(Text("Description label"))
        
        Text(observableProduct.description)
            .font(.caption)
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
            .accessibilityLabel(Text("Product description"))
            .accessibilityValue(Text(observableProduct.description))
            .accessibilityHint(Text("The full description of the product."))
        
        Text("Source: ")
            .font(.subheadline.bold())
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
            .accessibilityLabel(Text("Source label"))
        
        
        Text(observableProduct.source)
            .font(.caption)
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
            .accessibilityLabel(Text("Product source"))
            .accessibilityValue(Text(observableProduct.source))
            .accessibilityHint(Text("The source of the product.")) 
    }
}

#Preview {
    DetailsRow(animateDetails: .constant(true), observableProduct: .example)
}
