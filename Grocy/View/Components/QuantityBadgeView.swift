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
                .fill(Color.green)
                .frame(width: 30, height: 30)
            Text("\(quantity)")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
        }
    }
}


#Preview {
    QuantityBadgeView(quantity: 20)
}
