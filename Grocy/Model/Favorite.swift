//
//  Favorite.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import Foundation


struct Favorite {
    let id = UUID()
    var products: [Product] = []
    
    static let products: [Product] =  Bundle.main.decode(file: "products.json")
    static let example = Favorite(products: [products[0]])
}
