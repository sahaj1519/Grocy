//
//  User.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    
    let id: UUID
    var name: String
    var email: String
    var phone: Int
    var address: String
    var orders: [Order]

    
}

