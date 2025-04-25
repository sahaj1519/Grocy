//
//  FavoriteView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct FavoriteView: View {
    var favoriteProducts: Favorite
    @Bindable var cart: Cart
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 5),
        GridItem(.adaptive(minimum: 120), spacing: 5),
        GridItem(.adaptive(minimum: 120), spacing: 5)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                if favoriteProducts.observableProducts.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description: Text("You can tap the heart icon on any product to add it to your favorites.")
                    )
                    .padding(.top, 100)
                    .multilineTextAlignment(.center)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .accessibilityLabel(Text("No favorite products"))
                    .accessibilityHint(Text("You don't have any products in your favorites yet"))
                    
                } else {
                    Text("My Favorites")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .accessibilityLabel(Text("My Favorites"))
                    
                    Divider()
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        
                        ForEach(favoriteProducts.observableProducts, id: \.id) { product in
                            NavigationLink(value: product) {
                                SingleProductView(observableProduct: product, cart: cart, favoriteProducts: favoriteProducts)
                                    .transition(.asymmetric(insertion: .identity, removal: .scale(scale: 0.8).combined(with: .opacity)))
                                    .id(product.id)
                                    .accessibilityLabel(Text("\(product.name) in your favorites"))
                                    .accessibilityHint(Text("Tap to view details of \(product.name)"))
                                
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                favoriteProducts.observableProducts.remove(atOffsets: indexSet)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    .tint(.primary)
                }
                
            }
            .background(.green.opacity(0.05))
            .navigationDestination(for: ObservableProduct.self) { product in
                ProductDetailView(observableProduct: product, cart: cart)
            }
        }
    }
}

#Preview {
    FavoriteView(favoriteProducts: .example, cart: .example)
}
