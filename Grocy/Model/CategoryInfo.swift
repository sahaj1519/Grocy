//
//  CategoryInfo.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//
import SwiftUI
import Foundation

struct CategoryInfo: Identifiable, Codable {
    
    var id = UUID()
    let name: String
    let sfSymbol: String
    let colorHex: String
    let imageURL: URL?
    
    var color: Color {
           Color(hex: colorHex)
       }
    
    static func randomColor() -> Color {
        let colors: [Color] = [
            .red, .orange, .yellow, .green, .blue, .purple, .pink, .teal, .mint, .cyan
        ]
        return colors.randomElement() ?? .gray
    }
    
}
