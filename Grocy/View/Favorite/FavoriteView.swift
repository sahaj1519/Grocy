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
            GridItem(.adaptive(minimum: 150), spacing: 10)
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                if favoriteProducts.products.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description: Text("You can tap the heart icon on any product to add it to your favorites.")
                    )
                    .padding(.top, 100)
                    .multilineTextAlignment(.center)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    
                } else {
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        
                        ForEach(favoriteProducts.products, id: \.id) { product in
                            NavigationLink(value: product) {
                                SingleProductView(product: product, cart: cart, favoriteProducts: favoriteProducts)
                                    .transition(.asymmetric(insertion: .identity, removal: .scale(scale: 0.8).combined(with: .opacity)))
                                    .id(product.id)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                favoriteProducts.products.remove(atOffsets: indexSet)
                            }
                        }
                    }
                    .tint(.primary)
                }
                
            }
            .padding(20)
            .background(.green.opacity(0.05))
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product, cart: cart)
            }
        }
    }
}

#Preview {
    FavoriteView(favoriteProducts: .example, cart: .example)
}
