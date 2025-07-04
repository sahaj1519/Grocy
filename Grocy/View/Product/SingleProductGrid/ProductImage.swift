//
//  ProductImage.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ProductImage: View {
    var imageURL: URL
    @StateObject private var imageCache = ImageCache.shared
    
    @State private var imageData: Data? = nil
    @State private var isLoading: Bool = true

    private func loadImage() {
       
        if let cachedData = imageCache.getImage(for: imageURL) {
            self.imageData = cachedData
            self.isLoading = false
        } else {
            loadImageFromNetwork()
        }
    }

    private func loadImageFromNetwork() {
        Task {
            do {
                
                let (data, _) = try await URLSession.shared.data(from: imageURL)
                imageCache.cacheImage(data, for: imageURL)
                self.imageData = data
            } catch {
                self.imageData = nil
            }
        }
    }

    
    var body: some View {
        Group {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    
            } else {
                ProgressView()
                    .frame(width: 70, height: 40, alignment: .center)
                    .onAppear { loadImage() }
            }
        }

    }

}


#Preview {
    ProductImage(imageURL: URL(string: "https://imgur.com/y4r8YfJ.jpg")!)
}
