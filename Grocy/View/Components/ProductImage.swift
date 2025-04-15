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
                    .clipped()
                    .frame(width: 150, height: 150)
            } else {
                ProgressView()
                    .frame(width: 150, height: 150)
                    .onAppear { loadImage() }
            }
        }
        .frame(width: 150, height: 150)
    }

}


#Preview {
    ProductImage(imageURL: URL(string: "https://imgur.com/y4r8YfJ.jpg")!)
}
