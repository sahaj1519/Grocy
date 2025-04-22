//
//  BannersView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct BannersView: View {
   var banners: [Banner] = Bundle.main.decode(file: "Banner.json")

    @Environment(\.verticalSizeClass) private var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    var body: some View {
        
        TabView {
            ForEach(banners, id: \.self) {image in
                if isLandscape {
                    ProductImage(imageURL: image.imageURL)
                        .clipped()
                        .shadow(radius: 4)
                        .padding(5)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .clipShape(.rect(cornerRadius: 10))
                } else {
                    
                    ProductImage(imageURL: image.imageURL)
                        .clipped()
                        .shadow(radius: 4)
                        .padding(5)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 120)
        
        
        
        
    }
}

#Preview {
    BannersView()
}
