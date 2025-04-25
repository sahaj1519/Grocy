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
                    .accessibilityLabel(Text("\(category.name) category image"))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 130, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityLabel(Text("Placeholder image for \(category.name) category"))
            }
            
            
            Image(systemName: category.sfSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(category.color, .secondary)
                .clipShape(Circle())
                .accessibilityLabel(Text("Category: \(category.name)"))
                .accessibilityHint(Text("Tap to view products in \(category.name)"))
            
            Text(category.name)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(category.color)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding()
        .frame(maxWidth: 180, maxHeight: 180, alignment: .center)
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
        .accessibilityElement()
        .accessibilityLabel(category.name)
        .accessibilityHint(Text("Tap to see more about \(category.name)"))
        .accessibilityIdentifier("Explore_Category_\(category.name)")
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
