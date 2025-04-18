//
//  ProductInfoView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductInfoView: View {
    var product: Product

    var body: some View {
        VStack {
            Text(product.name)
                .font(.headline.bold())
                .lineLimit(1)
                .padding(.vertical, 0)
               
        }
        .padding(.vertical, 0)
       
       
    }
}

#Preview {
    ProductInfoView(product: .example)
}
