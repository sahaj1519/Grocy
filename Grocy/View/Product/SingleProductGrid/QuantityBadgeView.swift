//
//  QuantityBadgeView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct QuantityBadgeView: View {
    var quantity: Int

    var body: some View {
        ZStack {
            Circle()
                .fill(.green)
                .frame(width: 20, height: 20)
            Text("\(quantity)")
                .font(.caption2.bold())
                .foregroundColor(.white)
                
        }
    }
}


#Preview {
    QuantityBadgeView(quantity: 20)
}
