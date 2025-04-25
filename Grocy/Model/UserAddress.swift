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
    var addressType: String
    
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
        case addressType = "addressType"
    }
    
    init(id: UUID = UUID(), name: String, email: String, phone: String, city: String, state: String, country: String, district: String, street: String, pincode: String, landmark: String, addressType: String) {
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
        self.addressType = addressType
    }
    
    var isValidPincode: Bool {
        let cleaned = pincode.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleaned.count == 6 && cleaned.allSatisfy { $0.isNumber }
    }
    
    var hasValidAddress: Bool {
        let fields = [name, email, phone, state, city, district, street, country, landmark, addressType]
        
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
        !addressType.isEmpty &&
        isValidPincode
    }
    
    static let example = UserAddress(
            name: "Ajay",
            email: "ajay@example.com",
            phone: "9876543210",
            city: "Delhi",
            state: "Delhi",
            country: "India",
            district: "South",
            street: "Main Street",
            pincode: "110092",
            landmark: "Near Park",
            addressType: "Home"
        )
        
        func with(
            id: UUID? = nil,
            name: String? = nil,
            email: String? = nil,
            phone: String? = nil,
            city: String? = nil,
            state: String? = nil,
            country: String? = nil,
            district: String? = nil,
            street: String? = nil,
            pincode: String? = nil,
            landmark: String? = nil,
            addressType: String? = nil
        ) -> UserAddress {
            UserAddress(
                id: id ?? self.id,
                name: name ?? self.name,
                email: email ?? self.email,
                phone: phone ?? self.phone,
                city: city ?? self.city,
                state: state ?? self.state,
                country: country ?? self.country,
                district: district ?? self.district,
                street: street ?? self.street,
                pincode: pincode ?? self.pincode,
                landmark: landmark ?? self.landmark,
                addressType: addressType ?? self.addressType
            )
        }
    
}
