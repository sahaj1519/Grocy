//
//  AddedOverlayView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//

import SwiftUI

struct AddedOverlayView: View {
    let added: Bool

    var body: some View {
        Group {
            if added {
                Text("✓ Added!")
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(2)
                    .background(.green)
                    .clipShape(Capsule())
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(2)
            }
        }
    }
}

#Preview {
    AddedOverlayView(added: true)
}
