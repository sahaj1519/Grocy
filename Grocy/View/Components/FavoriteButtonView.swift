//
//  FavoriteButtonView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct FavoriteButtonView: View {
  
    @State private var isAnimate = false
    @Binding var favoriteProducts: Favorite
    @State private var isTappingDisabled = false
    @State private var isTapped = false
    var product: Product
    
    
    func addToFavorite(product: Product) {
        guard !favoriteProducts.products.contains(where: { $0.id == product.id }) else { return }
        favoriteProducts.products.append(product)
    }
    
    func removeFromFavorite(product: Product) {
        favoriteProducts.products.removeAll { $0.id == product.id}
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return favoriteProducts.products.contains { $0.id == product.id }
    }
    
    var body: some View {
        Button {
            guard !isTappingDisabled else { return }
            isTappingDisabled = true
            
            
            withAnimation(.easeOut(duration: 0.2)) {
                isAnimate = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if isFavorite(product) {
                    removeFromFavorite(product: product)
                } else {
                    addToFavorite(product: product)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isAnimate = false
                }
                isTapped = false
                isTappingDisabled = false
            }
            
        } label: {
            ZStack {
                Circle()
                    .fill(isFavorite(product) ? Color.red.opacity(0.35) : Color.white.opacity(0.9))
                    .frame(width: 35, height: 35)
                    .scaleEffect(isAnimate ? 1.25 : 1.0)
                    .opacity(isAnimate ? 0.75 : 1.0)
                
                Image(systemName: isFavorite(product) ? "heart.fill" : "heart")
                    .foregroundStyle(isFavorite(product) ? .red : .primary)
                    .font(.title2)
                    .scaleEffect(isAnimate ? 1.2 : 1.0)
                    .opacity(isTapped ? 1.0 : 0.85)
            }
            .animation(.easeInOut(duration: 0.25), value: isAnimate)
            .animation(.easeInOut(duration: 0.25), value: isTapped)
        }
        .buttonStyle(.plain)
        
    }
}


#Preview {
    FavoriteButtonView(favoriteProducts: .constant(.example), product: .example)
}
