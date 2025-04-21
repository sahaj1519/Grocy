//
//  Favorite.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import Foundation

@Observable
class Favorite: Codable, Equatable {
    
    var observableProducts: [ObservableProduct] = []
    
    enum CodingKeys: String, CodingKey {
        case _observableProducts = "observableProducts"
    }
    
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        lhs.observableProducts == rhs.observableProducts
    }
    
    func addToFavorite(product: ObservableProduct) {
        guard !observableProducts.contains(where: { $0.id == product.id }) else { return }
        observableProducts.append(product)
    }
    
    func removeFromFavorite(product: ObservableProduct) {
        observableProducts.removeAll { $0.id == product.id}
    }
    
    func isFavorite(_ product: ObservableProduct) -> Bool {
        return observableProducts.contains { $0.id == product.id }
    }
    
    
    static var example: Favorite {
        let favorite = Favorite()
        favorite.observableProducts = [ObservableProduct.example]
        return favorite
    }
}
