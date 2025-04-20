//
//  ProfileRowView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct ProfileRowView<Destination: View>: View {
    let systemImage: String
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 15) {
                Image(systemName: systemImage)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: 60, alignment: .leading)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.headline.bold())
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
        }
        .tint(.primary)
    }
}


#Preview {
    ProfileRowView(systemImage: "shippingbox", title: "Orders", destination: Text("Orders View"))
}
