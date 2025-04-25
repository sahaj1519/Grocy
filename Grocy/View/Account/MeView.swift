//
//  MeView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct MeView: View {
    @Bindable var user: DataModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Circle()
                    .fill(.green.opacity(0.3))
                    .blur(radius: 100)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center) {
                        MeHeaderView(user: user)
                        
                        Rectangle()
                            .fill(.primary)
                            .frame(width: 300, height: 1)
                            .padding(.bottom, 50)
                        
                        AllProfileRows(user: user, selectedTab: $selectedTab)
                    }
                    
                }
                .scrollBounceBehavior(.basedOnSize)
                .background(.ultraThinMaterial)
                
            }
            .toolbar {
                Button("Logout") {
                    user.logout()  // Properly clear session and UserDefaults
                    
                    Task { @MainActor in
                        try? await user.saveUserData()  // Save updated user data
                    }
                }
                .accessibilityLabel("Logout")
                .accessibilityHint("Logs out of your account and clears saved session.")
                .accessibilityIdentifier("Logout")
                .accessibilityAddTraits(.isButton)
            }
            
        }
    }
}

#Preview {
    MeView(user: .preview, selectedTab: .constant(.account))
}
