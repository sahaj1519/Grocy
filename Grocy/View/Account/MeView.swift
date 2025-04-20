//
//  MeView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct MeView: View {
    @Bindable var user: DataModel
  
    
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
                        
                        AllProfileRows(user: user)
                    }
                    
                }
                .scrollBounceBehavior(.basedOnSize)
                .background(.ultraThinMaterial)
            }
        
        }
    }
}

#Preview {
    MeView(user: .preview)
}
