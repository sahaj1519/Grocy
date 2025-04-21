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
            ShopView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                       
                }
               
            
            ExploreView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                
            
            
            CartView(cartProducts: viewModel.cart, user: viewModel.user)
            
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(viewModel.cart.totalItems)
            
            FavoriteView(favoriteProducts: viewModel.favoriteProducts, cart: viewModel.cart)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
                .badge(viewModel.favoriteProducts.observableProducts.count)
            
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



