//
//  ExclusiveOffers.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ExclusiveOffers: View {
     var products: [Product]
    @Binding var cart: Cart
    @Binding var favoriteProducts: Favorite

    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
                HStack {
                    Text("Exclusive Offer")
                        .font(.title2.weight(.heavy))
                    Spacer()
                    Button {
                        // show all offers
                    }label: {
                        Text("See all")
                            .font(.headline)
                            .foregroundStyle(Color(red: 0.1, green: 0.8, blue: 0.5))
                    }
                }
                .padding(.horizontal, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(products.prefix(3)) { product in
                            SingleProductView(product: product, cart: $cart, favoriteProducts: $favoriteProducts)
                                .frame(width: 150)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
        
    }
}

#Preview {
    ExclusiveOffers(products: Product.products, cart: .constant(.example), favoriteProducts: .constant(.example))
        
}
