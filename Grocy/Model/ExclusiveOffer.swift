//
//  ExclusiveOffer.swift
//  Grocy
//
//  Created by Ajay Sangwan on 15/04/25.
//

import Foundation

struct ExclusiveOffer: Identifiable, Codable, Hashable, Equatable {
    
    let id: UUID
    var discountedPrice: Decimal
    var expiresAt: Date
    var offerType: String
    var offerDetails: String
    
    // Computed property to check if the offer is still valid
    var isOfferValid: Bool {
        guard expiresAt > Date() else { return false }
        return true
    }
    
    var convertedDiscountedPrice: String {
        discountedPrice.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    
    
    static let example = ExclusiveOffer(id: UUID(), discountedPrice: Decimal(58), expiresAt: Date().addingTimeInterval(60 * 60 * 24), offerType: "Discount", offerDetails: "20% off!")
    
}
