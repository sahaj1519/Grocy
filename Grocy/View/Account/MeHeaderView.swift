//
//  MeHeaderView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 19/04/25.
//

import SwiftUI

struct MeHeaderView: View {
    @Bindable var user: DataModel
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if let data = user.currentUser.image, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .clipShape(.circle)
                } else {
                    
                    Image(systemName: "person.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .padding(40)
                        .background(.secondary)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke()
                        }
                    
                }
                
            }
            Text("\(user.currentUser.name)")
                .font(.title.bold())
            
            Text("\(user.currentUser.email)")
                .font(.title3.weight(.light))
            
        }
        .padding(.top,30)
        .padding(.horizontal, 20)
    }
}

#Preview {
    MeHeaderView(user: DataModel())
}
