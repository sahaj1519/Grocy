//
//  NewArrivalView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct  NewArrivalView: View {
    @Binding var observableProducts: [ObservableProduct]
    @Bindable var cart: Cart
     var favoriteProducts: Favorite
    
    var filteredProducts: [ObservableProduct] {
        observableProducts.filter { $0.newArrival == true }
    }
    
    var body: some View {
        NavigationStack {
            LazyVStack(alignment: .leading) {
                HStack {
                    Text("New Arrivals")
                        .font(.title3.weight(.heavy))
                    Spacer()
                    NavigationLink(
                        destination: ExploreView(
                            observableProducts: $observableProducts,
                            cart: cart,
                            favoriteProducts: favoriteProducts,
                            filter: { $0.newArrival },
                            filterTitle: "New Arrivals"
                        )
                    ) {
                        HStack(spacing: 4) {
                            Text("See all")
                                .font(.subheadline.weight(.bold))
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.headline.weight(.bold))
                        }
                        .foregroundColor(Color(red: 0.1, green: 0.8, blue: 0.5))
                    }
                    .accessibilityLabel(Text("See all new arivals"))
                    .accessibilityHint(Text("Tap to explore more new arrival products"))
                }
                .padding([.horizontal,.top])
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(filteredProducts.prefix(10)) { product in
                            NavigationLink(value: product) {
                                SingleProductView(observableProduct: product, cart: cart, favoriteProducts: favoriteProducts)
                                    .accessibilityLabel(Text("new arrival product: \(product.name)"))
                                    .accessibilityHint(Text("Tap to view product details"))
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
            .padding(.bottom, 5)
            .navigationDestination(for: ObservableProduct.self) { product in
                ProductDetailView(observableProduct: product, cart: cart)
            }
        }
    }
}

#Preview {
    NewArrivalView(observableProducts: .constant([.example]), cart: .example, favoriteProducts: .example)
        
}
