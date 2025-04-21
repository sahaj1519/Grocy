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
                
                BannersView(images: ["banner_top"])
                
                ExclusiveOffers(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                
                BestSellerView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                
                OrganicView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                
                NewArrivalView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                
                SeasonalView(observableProducts: $observableProducts, cart: cart, favoriteProducts: favoriteProducts)
                
            }
            .padding(0)
            //.frame(width: .infinity, alignment: .leading)
            .scrollBounceBehavior(.basedOnSize)
            .background(.green.opacity(0.05))
        
        }
       
    }
}

#Preview {
    ShopView(observableProducts: .constant([.example]),cart: .example, favoriteProducts: .example)
        
}
