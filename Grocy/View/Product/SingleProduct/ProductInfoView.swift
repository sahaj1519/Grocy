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
                .font(.headline.bold())
                .lineLimit(1)
                .padding(.vertical, 0)
               
        }
        .padding(.vertical, 0)
       
       
    }
}

#Preview {
    ProductInfoView(observableProduct: .example)
}
