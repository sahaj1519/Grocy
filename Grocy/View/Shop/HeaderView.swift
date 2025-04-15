//
//  HeaderView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .background(.clear)
                
            
            LocationView()
        }
        .padding(0)
    }
}

#Preview {
    HeaderView()
}
