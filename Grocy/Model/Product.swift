//
//  Product.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//


import Foundation

struct Product: Identifiable, Hashable, Codable, Equatable {
    
    let id: UUID
    var name: String
    var category: String
    var price: Decimal
    var unit: String
    var quantity: Int
    var thumbnail: URL
    var images: [URL]
    var exclusiveOffer: ExclusiveOffer?
    var isOffer: Bool
    
    static let products: [Product] = Bundle.main.decode(file: "products.json")
    static let example = products[0]
}
