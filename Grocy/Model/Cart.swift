//
//  Cart.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation


@Observable
class Cart {
   
    var products: [Product] = []

    func addToCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            products.append(newProduct)
        }
    }
    

    func quantity(for product: Product) -> Int {
        return products.first(where: { $0.id == product.id })?.quantity ?? 0
    }
    
    static var example: Cart {
        let cart = Cart()
        cart.products = [Product.example]
        return cart
    }
    
    
}
