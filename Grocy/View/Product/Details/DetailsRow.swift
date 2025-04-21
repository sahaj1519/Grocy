//
//  DetailsRow.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import SwiftUI

struct DetailsRow: View {
    @Binding var animateDetails: Bool
    @Bindable var observableProduct: ObservableProduct
    var body: some View {
        Text("Description: ")
            .font(.headline.bold())
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
        
        Text(observableProduct.description)
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
        
        Text("Source: ")
            .font(.headline.bold())
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
        
        
        Text(observableProduct.source)
            .opacity(animateDetails ? 1 : 0)
            .offset(y: animateDetails ? 0 : 20)
            .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
    }
}

#Preview {
    DetailsRow(animateDetails: .constant(true), observableProduct: .example)
}
