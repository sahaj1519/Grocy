//
//  ShopView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ShopView: View {
    @Binding var products: [Product]
   
    @Bindable var cart: Cart
    var favoriteProducts: Favorite
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                HeaderView()
                
                BannersView(images: ["banner_top"])
                
                ExclusiveOffers(products: $products, cart: cart, favoriteProducts: favoriteProducts)
                
                BestSellerView(products: $products, cart: cart, favoriteProducts: favoriteProducts)
                
                OrganicView(products: $products, cart: cart, favoriteProducts: favoriteProducts)
                
                NewArrivalView(products: $products, cart: cart, favoriteProducts: favoriteProducts)
                
                SeasonalView(products: $products, cart: cart, favoriteProducts: favoriteProducts)
                
            }
            .padding(0)
            .frame(width: .infinity, alignment: .leading)
            .scrollBounceBehavior(.basedOnSize)
            .background(.green.opacity(0.05))
        
        }
       
    }
}

#Preview {
    ShopView(products: .constant([.example]),cart: .example, favoriteProducts: .example)
        
}
