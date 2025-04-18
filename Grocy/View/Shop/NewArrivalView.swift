//
//  NewArrivalView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct  NewArrivalView: View {
    @Binding var products: [Product]
    @Bindable var cart: Cart
     var favoriteProducts: Favorite
    
    var filteredProducts: [Product] {
        products.filter { $0.newArrival == true }
    }
    
    var body: some View {
        NavigationStack {
            LazyVStack(alignment: .leading) {
                HStack {
                    Text("New Arrivals")
                        .font(.title.weight(.heavy))
                    Spacer()
                    NavigationLink(
                        destination: ExploreView(
                            products: $products,
                            cart: cart,
                            favoriteProducts: favoriteProducts,
                            filter: { $0.newArrival },
                            filterTitle: "New Arrivals"
                        )
                    ) {
                        Text("See all")
                            .font(.title2)
                            .foregroundStyle(Color(red: 0.1, green: 0.8, blue: 0.5))
                    }
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filteredProducts.prefix(10)) { product in
                            NavigationLink(value: product) {
                                SingleProductView(product: product, cart: cart, favoriteProducts: favoriteProducts)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                }
                .tint(.primary)
            }
            .background(.gray.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.bottom, 10)
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product, cart: cart)
            }
        }
    }
}

#Preview {
    NewArrivalView(products: .constant([.example]), cart: .example, favoriteProducts: .example)
        
}
