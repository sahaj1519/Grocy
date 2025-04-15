//
//  SingleProductViewViewModel.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

@Observable
class SingleProductViewModel {
    var addedProductID: UUID?
    var isPressed: Bool = false
    
    func addProductToCart(product: Product, cart: Cart, completion: @escaping (Cart) -> Void) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.15)) {
            isPressed = true
        }

        withAnimation(.easeInOut(duration: 0.2)) {
            addedProductID = product.id
        }
        
       
        var updateCart = cart
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
           updateCart.addToCart(product: product)
            completion(updateCart)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeOut(duration: 0.2)) {
                self.isPressed = false
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.addedProductID = nil
            }
        }
    }
}
