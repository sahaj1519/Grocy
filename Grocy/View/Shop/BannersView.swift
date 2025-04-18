//
//  BannersView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct BannersView: View {
    let images: [String]
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    var body: some View {
        
        TabView {
            ForEach(images, id: \.self) {image in
                if isLandscape {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .shadow(radius: 4)
                        .padding()
                        .frame(maxWidth: 600)
                } else {
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .shadow(radius: 4)
                        .padding()
                        .frame(width: 400, height: 140)
                }
                
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 150)
        
        
        
        
    }
}

#Preview {
    BannersView(images: ["banner_top"])
}
