//
//  ProductPriceAndAddButtonView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct ProductPriceAndAddButtonView: View {
    let product: Product
    let addAction: () -> Void

    var body: some View {
        HStack {
            Text("\(product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .font(.headline.bold())

            Spacer()

            Button(action: addAction) {
                Image(systemName: "plus")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(.green)
                    .clipShape(.rect(cornerRadius: 8))
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    ProductPriceAndAddButtonView(product: .example, addAction: { })
}
