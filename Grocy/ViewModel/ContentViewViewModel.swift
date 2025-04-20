//
//  ContentViewViewModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        
        var cart = Cart.loadFromUserDefaults() ?? Cart()
        var favoriteProducts = Favorite()
        var products: [Product] = []
        
        
        var user = DataModel()
        
        func loadProducts() async{
            products = Bundle.main.decode(file: "products.json")
        }
        
        
    }
}
