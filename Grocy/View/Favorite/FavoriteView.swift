//
//  FavoriteView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var favoriteProducts: Favorite
    @Binding var cart: Cart
    let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
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
                
                LazyVGrid(columns: columns) {
                    
                    
                    ForEach(favoriteProducts.products, id: \.id) { product in
                        
                        SingleProductView(product: product, cart: $cart, favoriteProducts: $favoriteProducts)
                            .shadow(radius: 1)
                            .transition(.asymmetric(insertion: .identity, removal: .scale(scale: 0.8).combined(with: .opacity)))
                            .id(product.id)
                    }
                    .onDelete { indexSet in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            favoriteProducts.products.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
            
        }
        .padding(20)
    }
}

#Preview {
    FavoriteView(favoriteProducts: .constant(.example), cart: .constant(.example))
}
