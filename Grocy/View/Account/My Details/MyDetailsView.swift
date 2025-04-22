//
//  MyDetailsView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct MyDetailsView: View {
    @Bindable var user: DataModel
  
    
    var body: some View {
        NavigationView {
            Form {
                MyDetailsHeaderView(user: user)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                
                UserDetailsView(user: user)
                    .tint(.primary)
            }
            .background(.ultraThinMaterial)
            .listStyle(InsetGroupedListStyle())  
            .navigationBarTitle("My Details", displayMode: .inline)
        }
    }
}

#Preview {
    MyDetailsView(user: .preview)
}
