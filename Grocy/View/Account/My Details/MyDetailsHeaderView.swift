//
//  MyDetailsHeaderView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//
import PhotosUI
import SwiftUI

struct MyDetailsHeaderView: View {
    @Bindable var user: DataModel
    @State private var selectedItem: PhotosPickerItem?
    
    func loadPhoto() async {
        if let selectedItem {
            do {
                if let data = try await selectedItem.loadTransferable(type: Data.self) {
                   Task { @MainActor in
                        user.currentUser.image = data
                       try await user.saveUserData()
                    }
                    
                }
            } catch {
                print("Failed to load image data: \(error.localizedDescription)")
            }
        }
    }
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            HStack(alignment: .center) {
                if let data = user.currentUser.image, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(.circle)
                } else {
                    
                    Image(systemName: "person.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .padding(50)
                        .background(.secondary)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke()
                        }
                    
                }
                
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image(systemName: "camera.fill")
                    .padding(10)
                    .background(.white)
                    .clipShape(.circle)
                    .overlay(
                        Circle()
                            .stroke(.blue, lineWidth: 1)
                    )
                   
            }
            .offset(x: -10, y: -5 )
            .onChange(of: selectedItem) {
                Task {
                    await loadPhoto()
                }
            }
        }
        
    }
}

#Preview {
    MyDetailsHeaderView(user: .preview)
}
