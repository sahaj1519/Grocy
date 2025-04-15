//
//  Cart.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation


struct Cart: Codable, Identifiable {
    var id = UUID()
    var products: [Product] = []
    
    
    mutating func addToCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            products.append(newProduct)
        }
    }
    
    
    static var example: Cart {
        Cart(products: [
            Product(
                id: UUID(),
                name: "Tomatoes",
                category: "Vegetables",
                price: 20,
                unit: "1 Kg",
                quantity: 1,
                thumbnail: URL(string: "https://imgur.com/ZCtEukWm.jpg")!,
                images: [
                    URL(string: "https://imgur.com/ZCtEukW.jpg")!,
                    URL(string: "https://imgur.com/ZCtEukWs.jpg")!,
                    URL(string: "https://imgur.com/ZCtEukWm.jpg")!,
                    URL(string: "https://imgur.com/ZCtEukWl.jpg")!
                ]
            )
        ])
    }
    
    
}
