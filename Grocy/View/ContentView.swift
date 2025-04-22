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
        TabView(selection: $viewModel.selectedTab) {
            ShopView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                       
                }
                .tag(Tab.shop)
            
            ExploreView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(Tab.explore)
            
            
            CartView(cartProducts: viewModel.cart, user: viewModel.user)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(viewModel.cart.totalItems)
                .tag(Tab.cart)
            
            FavoriteView(favoriteProducts: viewModel.favoriteProducts, cart: viewModel.cart)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
                .badge(viewModel.favoriteProducts.observableProducts.count)
                .tag(Tab.favorite)
            
            MeView(user: viewModel.user, selectedTab: $viewModel.selectedTab)
                .tabItem {
                    Label("Account", systemImage: "person")
                }
                .tag(Tab.account)

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



