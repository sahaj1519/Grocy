//
//  ShopView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ShopView: View {
    @Binding var observableProducts: [ObservableProduct]
   
    @Bindable var cart: Cart
    var favoriteProducts: Favorite
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                HeaderView()
                
                BannersView()
                    .accessibilityLabel(Text("Banners"))
                    .accessibilityHint(Text("Swipe to see featured banners"))
                
                ExclusiveOffers(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                    .accessibilityLabel(Text("Exclusive offers"))
                
                BestSellerView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                    .accessibilityLabel(Text("Best sellers"))
                
                
                OrganicView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                    .accessibilityLabel(Text("Organic products"))
                
                NewArrivalView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                    .accessibilityLabel(Text("New arrivals"))
                
                
                SeasonalView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                    .accessibilityLabel(Text("Seasonal products"))
                
            }
            .padding(0)
            .scrollBounceBehavior(.basedOnSize)
            .background(.green.opacity(0.05))
            
        }
        
    }
}

#Preview {
    ShopView(observableProducts: .constant([.example]),cart: .example, favoriteProducts: .example)
        
}
