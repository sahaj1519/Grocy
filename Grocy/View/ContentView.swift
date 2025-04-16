//
//  ContentView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cart = Cart()
    @State var favoriteProducts = Favorite()
    @State var products: [Product] = []
    func loadProducts() async{
        products = Bundle.main.decode(file: "products.json")
    }

    var body: some View {
        TabView {
            ShopView(products: $products, cart: cart, favoriteProducts: $favoriteProducts)
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                }
               
            
            ExploreView(products: $products, cart: cart, favoriteProducts: $favoriteProducts)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                
            
            
            CartView(cartProducts: cart)
            
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                
            FavoriteView(favoriteProducts: $favoriteProducts, cart: cart)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
 
            MeView()
            
                .tabItem {
                    Label("Account", systemImage: "person")
                }
               
        }
        .tint(.green)
        .task {
            await loadProducts()
        }
        
    }
}

#Preview {
    ContentView()
        
}



