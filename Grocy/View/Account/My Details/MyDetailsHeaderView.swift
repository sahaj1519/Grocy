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
                    await MainActor.run {
                        withAnimation {
                            user.currentUser.image = data
                        }
                    }
                    try await user.saveUserData()
                    
                    await MainActor.run {
                        self.selectedItem = nil
                    }
                }
            } catch {
                print("Failed to load image data: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                HStack {
                    if let data = user.currentUser.image, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .padding(50)
                            .background(Color.secondary)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    }
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Image(systemName: "camera.fill")
                        .padding(10)
                        .background(.white)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
                .offset(x: -10, y: -10) 
                .onChange(of: selectedItem) {
                    Task {
                        await loadPhoto()
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(radius: 10)
        
    }
}

#Preview {
    MyDetailsHeaderView(user: .preview)
}
