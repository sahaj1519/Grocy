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
    
}
