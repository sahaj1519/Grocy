//
//  ProductInfoView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductInfoView: View {
    @Bindable var observableProduct: ObservableProduct
    
    var body: some View {
        VStack {
            Text(observableProduct.name)
                .font(.system(size: 12).bold())
                .lineLimit(3)
                .padding(.vertical, 0)
                .padding(.horizontal, 2)
                .accessibilityLabel(Text(observableProduct.name))
                .accessibilityHint(Text("Product name"))
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("Explore_Product_\(observableProduct.name)")
            
        }
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .ignore)
        
        
    }
}

#Preview {
    ProductInfoView(observableProduct: .example)
}
