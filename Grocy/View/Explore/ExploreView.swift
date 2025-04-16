//
//  ExploreView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText = ""
    @Binding var products: [Product]
    @Bindable var cart: Cart
    @Binding var favoriteProducts: Favorite
    
    @State private var path = NavigationPath()
   
    let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity), spacing: 15),
        GridItem(.adaptive(minimum: 200, maximum: .infinity), spacing: 15)
    ]
    var filterProducts: [Product] {
        if searchText.isEmpty {
            products
        } else {
            products.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(filterProducts) { product in

                        SingleProductView(product: product, cart: cart, favoriteProducts: $favoriteProducts)
                                               
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .tint(.green.opacity(0.05))
                .navigationTitle("Find Products")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(for: Product.self) { product in
                ExploreView(products: $products , cart: cart, favoriteProducts: $favoriteProducts)
            }
        }
        
    }
}


#Preview {
    ExploreView(products: .constant([.example]) , cart: .example, favoriteProducts: .constant(.example))
}
