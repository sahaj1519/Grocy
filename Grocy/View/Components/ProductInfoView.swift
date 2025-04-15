//
//  ProductInfoView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductInfoView: View {
    let product: Product

    var body: some View {
        VStack(spacing: 2) {
            Text(product.name)
                .font(.subheadline.bold())
            Text("\(product.unit) x \(product.quantity)")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProductInfoView(product: .example)
}
