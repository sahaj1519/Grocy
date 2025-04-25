//
//  LabelView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct LabelView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(minWidth: 80, idealWidth: 100, maxWidth: 120, alignment: .leading)
                .accessibilityHidden(true)
            
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(label): \(value)")
            
            Spacer()
        }
    }
}



#Preview {
    LabelView(label: "Landmark", value: " near tower")
}
