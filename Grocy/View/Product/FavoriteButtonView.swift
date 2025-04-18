//
//  FavoriteButtonView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct FavoriteButtonView: View {
  
    @State private var isAnimate = false
    var favoriteProducts: Favorite
    @State private var isTappingDisabled = false
    @State private var isTapped = false
    var product: Product
    
    
    
    
    var body: some View {
        Button {
            guard !isTappingDisabled else { return }
            isTappingDisabled = true
            
            
            withAnimation(.easeOut(duration: 0.2)) {
                isAnimate = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if  favoriteProducts.isFavorite(product) {
                    favoriteProducts.removeFromFavorite(product: product)
                } else {
                    favoriteProducts.addToFavorite(product: product)
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
                    .fill( favoriteProducts.isFavorite(product) ? Color.red.opacity(0.35) : Color.gray.opacity(0.8))
                    .frame(width: 35, height: 35)
                    .scaleEffect(isAnimate ? 1.25 : 1.0)
                    .opacity(isAnimate ? 0.75 : 1.0)
                
                Image(systemName:  favoriteProducts.isFavorite(product) ? "heart.fill" : "heart")
                    .foregroundStyle( favoriteProducts.isFavorite(product) ? .red : .white)
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
    FavoriteButtonView(favoriteProducts: .example, product: .example)
}
