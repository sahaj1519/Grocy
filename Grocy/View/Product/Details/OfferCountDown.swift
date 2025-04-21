//
//  OfferCountDown.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//
import SwiftUI

struct OfferCountDown: View {
    @Bindable var observableProduct: ObservableProduct
    @State private var timeLeft: TimeInterval = 0

    var body: some View {
        VStack {
            if timeLeft > 0 {
                let days = Int(timeLeft) / 86400
                let hours = (Int(timeLeft) % 86400) / 3600
                let minutes = (Int(timeLeft) % 3600) / 60
                let seconds = Int(timeLeft) % 60
                
                Text("⏳ \(String(format: "%02dd : %02dh : %02dm : %02ds", days, hours, minutes, seconds))")
                    .font(.caption.bold())
                    .foregroundColor(.red)
                    .padding(8)
                    .background(.regularMaterial)
                    .clipShape(.capsule)
            } else {
                Text("")
                    
            }
        }
        .onAppear {
            guard let endTime = observableProduct.exclusiveOffer?.expiresAt else { return }

            // Immediately calculate remaining time before timer starts
            timeLeft = endTime.timeIntervalSinceNow

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                let remaining = endTime.timeIntervalSinceNow
                if remaining <= 0 {
                    timeLeft = 0
                    timer.invalidate()
                } else {
                    timeLeft = remaining
                }
            }
        }
    }
}

#Preview {
    OfferCountDown(observableProduct: ObservableProduct(product: .example))
}
