//
//  LocationView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct LocationView: View {
    @State private var locationManager = LocationManager()
    var body: some View {
        
       
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 20, height: 20)
                        .accessibilityLabel(Text("Location icon"))
                    
                    Text(locationManager.address)
                        .font(.headline)
                }
                .padding(0)
                .accessibilityElement()
                .accessibilityLabel(Text("Current location: \(locationManager.address)"))
                .accessibilityHint(Text("Location of the user"))
            
       
    }
    
}


#Preview {
    LocationView()
}
