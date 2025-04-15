//
//  Order.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation

struct Order: Hashable, Codable, Identifiable {
    var id = UUID()
    var date: Date
    var isCompleted: Bool
    var products: [Product]
    
    
    
    static let products: [Product] = Bundle.main.decode(file: "products.json")
    static let example = Order(date: .now, isCompleted: false, products: products)
}
