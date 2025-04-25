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
    @Bindable var observableProduct: ObservableProduct
    
    
    
    
    var body: some View {
        Button {
            guard !isTappingDisabled else { return }
            isTappingDisabled = true
            
            
            withAnimation(.easeOut(duration: 0.2)) {
                isAnimate = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if  favoriteProducts.isFavorite(observableProduct) {
                    favoriteProducts.removeFromFavorite(product: observableProduct)
                } else {
                    favoriteProducts.addToFavorite(product: observableProduct)
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
                    .fill( favoriteProducts.isFavorite(observableProduct) ? Color.red.opacity(0.35) : Color.gray.opacity(0.8))
                    .frame(width: 25, height: 25)
                    .scaleEffect(isAnimate ? 1.25 : 1.0)
                    .opacity(isAnimate ? 0.75 : 1.0)
                
                Image(systemName:  favoriteProducts.isFavorite(observableProduct) ? "heart.fill" : "heart")
                    .foregroundStyle( favoriteProducts.isFavorite(observableProduct) ? .pink : .white)
                    .font(.caption)
                    .scaleEffect(isAnimate ? 1.2 : 1.0)
                    .opacity(isTapped ? 1.0 : 0.85)
            }
            .accessibilityLabel("Favorite Button")
            .accessibilityHint("Tap to add/remove from favorites")
            .accessibilityIdentifier("favorite_button")
            .animation(.easeInOut(duration: 0.25), value: isAnimate)
            .animation(.easeInOut(duration: 0.25), value: isTapped)
        }
        .buttonStyle(.plain)
        
    }
}


#Preview {
    FavoriteButtonView(favoriteProducts: .example, observableProduct: .example)
}
