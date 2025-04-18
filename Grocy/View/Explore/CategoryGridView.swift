//
//  CategoryGridView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import SwiftUI

struct CategoryGridView: View {
    let category: CategoryInfo
    
    var onTap: () -> Void
    
    @State private var backgroundColor: Color = CategoryInfo.randomColor()
    
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageURL = category.imageURL {
                ProductImage(imageURL: imageURL)
                    .frame(width: 130, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 130, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            
            Image(systemName: category.sfSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(category.color, .secondary)
                .clipShape(Circle())
            
            Text(category.name)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(category.color)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding()
        .frame(minWidth: 170, maxWidth: .infinity, minHeight: 230, maxHeight: 250, alignment: .center)
        .fixedSize(horizontal: false, vertical: false)
        .background(backgroundColor.opacity(0.07))
        .clipShape(.rect(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(backgroundColor, lineWidth: 1.3)
        )
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    CategoryGridView(
        category: CategoryInfo(
            name: "Fruits",
            sfSymbol: "applelogo",
            colorHex: "#FF5733",
            imageURL: URL(string: "https://i.imgur.com/PPhDbC7t.jpg")
        ),
        onTap: { }
    )
}
