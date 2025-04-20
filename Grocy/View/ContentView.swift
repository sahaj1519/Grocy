//
//  ContentView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ContentView: View {
    
   @State private var viewModel = ViewModel()

    var body: some View {
        TabView {
            ShopView(products: $viewModel.products, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                       
                }
               
            
            ExploreView(products: $viewModel.products, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                
            
            
            CartView(cartProducts: viewModel.cart, user: viewModel.user)
            
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                
            FavoriteView(favoriteProducts: viewModel.favoriteProducts, cart: viewModel.cart)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
 
            MeView(user: viewModel.user)
            
                .tabItem {
                    Label("Account", systemImage: "person")
                }
               
        }
        
        .tint(Color(red: 0.2, green: 0.5, blue: 0.25))
        .task {
            Task { @MainActor in
                await viewModel.loadProducts()
                try await viewModel.user.loadUserData()
               
            }
        }
        
    }
}

#Preview {
    ContentView()
        
}



