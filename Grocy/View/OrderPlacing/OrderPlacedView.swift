//
//  OrderPlacedView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 19/04/25.
//

import SwiftUI

struct OrderPlacedView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.green.opacity(0.6))
                .blur(radius: 180)
            
            VStack(spacing: 20) {
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.green)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                        ) {
                            scale = 1.3
                        }
                    }
                
                Text("Your Order has been accepted!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Great! Your order is on the way \nand will be with you soon.")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    dismiss()
                }
            }
        }
    }
}



#Preview {
    OrderPlacedView()
}
