//
//  UserAddress.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import Foundation

struct UserAddress: Codable, Equatable, Hashable, Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var phone: String
    var city: String
    var state: String
    var country: String
    var district: String
    var street: String
    var pincode: String
    var landmark: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case phone = "phone"
        case city = "city"
        case state = "state"
        case country = "country"
        case district = "district"
        case street = "street"
        case pincode = "pincode"
        case landmark = "landmark"
    }
    
    init(id: UUID = UUID(), name: String, email: String, phone: String, city: String, state: String, country: String, district: String, street: String, pincode: String, landmark: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.city = city
        self.state = state
        self.country = country
        self.district = district
        self.street = street
        self.pincode = pincode
        self.landmark = landmark
    }
    
    var isValidPincode: Bool {
        let cleaned = pincode.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleaned.count == 6 && cleaned.allSatisfy { $0.isNumber }
    }
    
    var hasValidAddress: Bool {
        let fields = [name, email, phone, state, city, district, street, country, landmark]
        
        let allFieldsValid = fields.allSatisfy {
            !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        return allFieldsValid && isValidPincode
    }
    
    var isValidPhoneNumber: Bool {
        let cleanedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Indian phone numbers must be 10 digits long and start with 7, 8, or 9.
        let phoneRegex = "^[789][0-9]{9}$"
        
        // Check if the phone number matches the regex pattern
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: cleanedPhone)
    }
    static func == (lhs: UserAddress, rhs: UserAddress) -> Bool {
        lhs.id == rhs.id
    }
    
    var isComplete: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !phone.isEmpty &&
        !street.isEmpty &&
        !city.isEmpty &&
        !state.isEmpty &&
        !country.isEmpty &&
        !district.isEmpty &&
        !landmark.isEmpty &&
        isValidPincode
    }
    
}
