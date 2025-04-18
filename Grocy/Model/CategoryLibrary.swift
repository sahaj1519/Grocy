//
//  CategoryLibrary.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import Foundation


struct CategoryLibrary {
    static let all: [CategoryInfo] = [
        CategoryInfo(name: "Fruits", sfSymbol: "applelogo", colorHex: "#FF5733", imageURL: URL(string: "https://i.imgur.com/ETLCCkSt.jpg")),
        CategoryInfo(name: "Vegetables", sfSymbol: "leaf", colorHex: "#28A745", imageURL: URL(string: "https://i.imgur.com/e1pkHo3t.jpg")),
        CategoryInfo(name: "Dairy", sfSymbol: "circle.grid.cross", colorHex: "#007BFF", imageURL: URL(string: "https://i.imgur.com/zpR7X2Kt.jpg")),
        CategoryInfo(name: "Bakery", sfSymbol: "birthday.cake.fill", colorHex: "#FF69B4", imageURL: URL(string: "https://i.imgur.com/wA6VNCut.jpg")),
        CategoryInfo(name: "Spreads", sfSymbol: "drop.fill", colorHex: "#000000", imageURL: URL(string: "https://i.imgur.com/JbvJ5S0t.jpg")),
        CategoryInfo(name: "Beverages", sfSymbol: "cup.and.saucer.fill", colorHex: "#800080", imageURL: URL(string: "https://i.imgur.com/gDDbLcKt.jpg")),
        CategoryInfo(name: "Grains", sfSymbol: "leaf.circle", colorHex: "#8B4513", imageURL: URL(string: "https://i.imgur.com/PfZV8Bit.jpg")),
        CategoryInfo(name: "Breakfast", sfSymbol: "sunrise.fill", colorHex: "#FFA500", imageURL: URL(string: "https://i.imgur.com/PPhDbC7t.jpg"))
    ]

    static func info(for name: String) -> CategoryInfo? {
        return all.first { $0.name.lowercased() == name.lowercased() }
    }
}
