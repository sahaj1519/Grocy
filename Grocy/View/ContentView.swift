//
//  ContentView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ContentView: View {
    
   @State private var viewModel = ViewModel()
    @Bindable var user: DataModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ShopView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                        .accessibilityIdentifier("Shop")
                       
                }
                .tag(Tab.shop)
            
            ExploreView(observableProducts: $viewModel.observableProducts, cart: viewModel.cart, favoriteProducts: viewModel.favoriteProducts)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                        .accessibilityIdentifier("Explore")
                }
                .tag(Tab.explore)
            
            
            CartView(cartProducts: viewModel.cart, user: user)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                        .accessibilityIdentifier("Cart")
                }
                .badge(viewModel.cart.totalItems)
                .tag(Tab.cart)
            
            FavoriteView(favoriteProducts: viewModel.favoriteProducts, cart: viewModel.cart)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                        .accessibilityIdentifier("Favorite")
                }
                .badge(viewModel.favoriteProducts.observableProducts.count)
                .tag(Tab.favorite)
            
            MeView(user: user, selectedTab: $viewModel.selectedTab)
                .tabItem {
                    Label("Account", systemImage: "person")
                        .accessibilityIdentifier("Account")
                }
                .tag(Tab.account)

        }
        
        .tint(Color(red: 0.2, green: 0.5, blue: 0.25))
        .task {
            Task { @MainActor in
                await viewModel.loadProducts()
                
            }
        }
        
    }
}

#Preview {
    ContentView(user: .preview)
        
}



