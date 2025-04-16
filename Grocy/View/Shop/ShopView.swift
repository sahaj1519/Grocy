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
    @Binding var favoriteProducts: Favorite
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                HeaderView()
                
                BannersView(images: ["banner_top"])
                
                ExclusiveOffers(products: $products, cart: cart, favoriteProducts: $favoriteProducts)
                
                
            }
            .padding(.horizontal, 8)
            .scrollBounceBehavior(.basedOnSize)
            
        }
    }
}

#Preview {
    ShopView(products: .constant([.example]),cart: .example, favoriteProducts: .constant(.example))
        
}
