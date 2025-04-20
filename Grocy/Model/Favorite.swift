//
//  Favorite.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import Foundation

@Observable
class Favorite: Codable, Equatable {
    
    var products: [Product] = []
    
    enum CodingKeys: String, CodingKey {
        case _products = "products"
    }
    
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        lhs.products == rhs.products
    }
    
    func addToFavorite(product: Product) {
        guard !products.contains(where: { $0.id == product.id }) else { return }
        products.append(product)
    }
    
    func removeFromFavorite(product: Product) {
        products.removeAll { $0.id == product.id}
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return products.contains { $0.id == product.id }
    }
    
    
    static var example: Favorite {
        let favorite = Favorite()
        favorite.products = [Product.example]
        return favorite
    }
}
