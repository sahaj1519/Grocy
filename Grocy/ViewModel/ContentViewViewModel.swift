//
//  ContentViewViewModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import Foundation

enum Tab {
    case shop
    case explore
    case cart
    case favorite
    case account
}


extension ContentView {
    @Observable
    class ViewModel {
        
        var cart = Cart.loadFromUserDefaults() ?? Cart()
        var favoriteProducts = Favorite()
        var observableProducts: [ObservableProduct] = []
        
        var selectedTab: Tab = .shop
        
        var user = DataModel()
        
        func loadProducts() async {
            let rawProducts: [Product] = Bundle.main.decode(file: "products.json")
            self.observableProducts = rawProducts.map { ObservableProduct(product: $0) }
        }
        
        
        
        func product(withId id: UUID) -> ObservableProduct? {
            observableProducts.first { $0.id == id }
        }
        
        
    }
}
