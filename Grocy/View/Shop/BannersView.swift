//
//  BannersView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct BannersView: View {
    let images: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(images, id: \.self) {image in
                    
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 4)
                        .padding()
                        .frame(width: 400, height: 120)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
           
        }
        .scrollBounceBehavior(.basedOnSize)
        .padding(.vertical,5)
        
        
        
    }
}

#Preview {
    BannersView(images: ["banner_top"])
}
