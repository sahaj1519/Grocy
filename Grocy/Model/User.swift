//
//  User.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation
   
struct User: Codable, Hashable, Identifiable, Equatable {
    
    var id = UUID()
    var image: Data?
    var name: String
    var email: String
    var password: String = ""
    var phone: String
    var orders: [Order]
    var favorite: Favorite?
    var cart: Cart?
    var address: [UserAddress]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case name = "name"
        case email = "email"
        case password = "password"
        case phone = "phone"
        case orders = "orders"
        case favorite = "favorite"
        case cart = "cart"
        case address = "address"
    }
    
    var isSignUpDataValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !(password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) &&
        isValidPhoneNumber
    }

    
    var sortedOrdersByDate: [Order] {
        orders.sorted { $0.date > $1.date }
    }
    
    var primaryAddress: UserAddress {
        get {
            address.first ?? UserAddress(
                name: "", email: "", phone: "", city: "", state: "", country: "", district: "", street: "", pincode: "", landmark: "", addressType: "Home"
            )
        }
        set {
            if address.isEmpty {
                address.append(newValue)
            } else {
                address[0] = newValue
            }
        }
    }
    
    var canPlaceOrder: Bool {
        
        let hasValidAddress = primaryAddress.hasValidAddress
        let hasValidPhoneNumber = primaryAddress.isValidPhoneNumber
        
        return  hasValidPhoneNumber && hasValidAddress
    }
    
    
    
    var isValidPhoneNumber: Bool {
        let cleanedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Indian phone numbers must be 10 digits long and start with 7, 8, or 9.
        let phoneRegex = "^[789][0-9]{9}$"
        
        // Check if the phone number matches the regex pattern
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: cleanedPhone)
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(email)
        hasher.combine(phone)
        hasher.combine(address)
        
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.email == rhs.email &&
        lhs.phone == rhs.phone &&
        lhs.address == rhs.address
        
        
    }
    
    static let example = User(
        id: UUID(),
        name: "john akia rom",
        email: "akia@example.com",
        password: "password",
        phone: "1234567890",
        orders: [],
        favorite: nil,
        cart: nil,
        address: []
    )
    
    
    
    
}
