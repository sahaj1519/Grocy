//
//  ExclusiveOffers.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ExclusiveOffers: View {
    @Binding var products: [Product]
    @Bindable var cart: Cart
    @Binding var favoriteProducts: Favorite

    var filteredProducts: [Product] {
        products.filter { $0.isOffer == true }
    }
    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
            HStack {
                Text("Exclusive Offer")
                    .font(.title2.weight(.heavy))
                Spacer()
                NavigationLink(destination: ExploreView(products: $products, cart: cart, favoriteProducts: $favoriteProducts)) {
                    
                    
                    Text("See all")
                        .font(.headline)
                        .foregroundStyle(Color(red: 0.1, green: 0.8, blue: 0.5))
                }
            }
            .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(filteredProducts.prefix(3)) { product in
                        SingleProductView(product: product, cart: cart, favoriteProducts: $favoriteProducts)
                            .frame(width: 150)
                    }
                }
                .padding(.horizontal)
            }
        }
        
        
    }
}

#Preview {
    ExclusiveOffers(products: .constant([.example]), cart: .example, favoriteProducts: .constant(.example))
        
}
