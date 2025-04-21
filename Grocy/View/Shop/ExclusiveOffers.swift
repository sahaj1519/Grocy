//
//  ExclusiveOffers.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ExclusiveOffers: View {
    @Binding var observableProducts: [ObservableProduct]
    @Bindable var cart: Cart
     var favoriteProducts: Favorite
    
    var filteredProducts: [ObservableProduct] {
        observableProducts.filter { $0.isOffer == true }
    }
    
    var body: some View {
        NavigationStack {
            LazyVStack(alignment: .leading) {
                HStack {
                    Text("Exclusive Offer")
                        .font(.title.weight(.heavy))
                    
                    Spacer()
                    NavigationLink(
                        destination: ExploreView(
                            observableProducts: $observableProducts,
                            cart: cart,
                            favoriteProducts: favoriteProducts,
                            filter: { $0.isOffer },
                            filterTitle: "Exclusive Offer"
                        )
                    ) {
                        Text("See all")
                            .font(.title2.bold())
                            .foregroundStyle(Color(red: 0.1, green: 0.8, blue: 0.5))
                    }
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filteredProducts.prefix(10)) { product in
                            NavigationLink(value: product) {
                                SingleProductView(
                                    observableProduct: product,
                                    cart: cart,
                                    favoriteProducts: favoriteProducts
                                )
                                
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
            .navigationDestination(for: ObservableProduct.self) { product in
                ProductDetailView(observableProduct: product, cart: cart)
            }
            
        }
    }
}

#Preview {
    ExclusiveOffers(observableProducts: .constant([.example]), cart: .example, favoriteProducts: .example)
        
}
