//
//  OfferRibbon.swift
//  Grocy
//
//  Created by Ajay Sangwan on 17/04/25.
//

import SwiftUI


struct AnyShape: Shape, @unchecked Sendable {
    private let _path: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        self._path = shape.path(in:)
    }

    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}


struct OfferRibbon: View {
    @Bindable var observableProduct: ObservableProduct
    var showText: String
    var text: String
    var font: Font = .caption2
    var fontWeight: Font.Weight = .black
    var foregroundColor: Color = .white
    var backgroundColor: Color = .red
    var shape: AnyShape = AnyShape(Capsule())
    var rotation: Double = -45
    var offsetX: CGFloat = -20
    var offsetY: CGFloat = 10
    var shadowRadius: CGFloat = 1
    
    // Accessibility label and hint
    var accessibilityLabel: String {
        "\(observableProduct.percentDiscount == "0%" ? text : observableProduct.percentDiscount) \(showText) offer ribbon"
    }
    
    var accessibilityHint: String {
        "Discount or special offer applied to the product"
    }
    
    var body: some View {
        
        Text("\(String(describing: observableProduct.percentDiscount == "0%" ? text : observableProduct.percentDiscount)) \(showText)")
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(foregroundColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(backgroundColor)
            .clipShape(shape)
            .rotationEffect(.degrees(rotation))
            .offset(x: offsetX, y: offsetY)
            .shadow(radius: shadowRadius)
            .accessibilityLabel(Text(accessibilityLabel))
            .accessibilityHint(Text(accessibilityHint))
          
        
    }
}



#Preview {
    VStack(spacing: 20) {
        OfferRibbon(
            observableProduct: .example,
            showText: "Off",
            text: "OFFER")
        .accessibilityLabel(Text("OFFER OFF"))
        .accessibilityHint(Text("Discount offer applied"))
        
        OfferRibbon(
            observableProduct: .example,
            showText: "Off",
            text: "SALE",
            foregroundColor: .black,
            backgroundColor: .yellow,
            shape: AnyShape(RoundedRectangle(cornerRadius: 5)),
            rotation: -30,
            offsetX: -10,
            offsetY: 15
        )
        .accessibilityLabel(Text("SALE OFF"))
        .accessibilityHint(Text("Sale offer applied"))
    }
}

