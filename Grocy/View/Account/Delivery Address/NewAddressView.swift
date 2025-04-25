//
//  NewAddressView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//
import SwiftUI

struct NewAddressView: View {
    @Bindable var user: DataModel
    var address: UserAddress
    
    
    @Environment(\.dismiss) var dismiss
    
    private var addressBinding: Binding<UserAddress> {
        Binding<UserAddress>(
            get: {
                user.currentUser.address.first(where: { $0.id == address.id }) ?? address
            },
            set: { newValue in
                if let index = user.currentUser.address.firstIndex(where: { $0.id == address.id }) {
                    user.currentUser.address[index] = newValue
                } else {
                    user.currentUser.address.append(newValue)
                }
            }
        )
    }
    
    
    var body: some View {
        
        Form {
            TextField("Name", text: addressBinding.name)
                .textContentType(.name)
                .accessibilityLabel("Full Name")
            
            TextField("Email", text: addressBinding.email)
                .textContentType(.emailAddress)
                .accessibilityLabel("Email Address")
            TextField("Phone Number", text: addressBinding.phone)
                .textContentType(.telephoneNumber)
                .foregroundColor(addressBinding.wrappedValue.isValidPhoneNumber ? .primary : .red)
                .onChange(of: addressBinding.wrappedValue.phone) { _, newValue in
                    addressBinding.wrappedValue.phone = newValue.filter { $0.isNumber }
                }
                .accessibilityLabel("Phone Number")
                .accessibilityHint("Enter a 10-digit phone number")
            
            if !addressBinding.wrappedValue.isValidPhoneNumber {
                Text("Please enter a valid 10-digit phone number.")
                    .foregroundColor(.red)
                    .font(.footnote)
                    .accessibilityLabel("Invalid phone number")
                    .accessibilityValue("Please enter a valid 10-digit phone number.")
                    .accessibilityHint("VoiceOver will read this when the number is invalid.")
                    .onAppear {
                        UIAccessibility.post(notification: .announcement, argument: "Please enter a valid 10-digit phone number.")
                    }
            }
            
            TextField("Street", text: addressBinding.street, axis: .vertical)
                .textContentType(.fullStreetAddress)
                .autocapitalization(.words)
                .autocorrectionDisabled()
                .accessibilityLabel("Street Address")
            
            TextField("Landmark", text: addressBinding.landmark)
                .textContentType(.streetAddressLine1)
                .accessibilityLabel("Landmark")
            TextField("Country", text: addressBinding.country)
                .textContentType(.countryName)
                .accessibilityLabel("Country")
            TextField("State", text: addressBinding.state)
                .textContentType(.addressState)
                .accessibilityLabel("State")
            TextField("City", text: addressBinding.city)
                .textContentType(.addressCity)
                .accessibilityLabel("City")
            TextField("District", text: addressBinding.district)
                .textContentType(.sublocality)
                .accessibilityLabel("District")
            TextField("Pincode", text: addressBinding.pincode)
                .textContentType(.postalCode)
                .keyboardType(.numberPad)
                .foregroundColor(addressBinding.wrappedValue.isValidPincode ? .primary : .red)
                .onChange(of: addressBinding.wrappedValue.pincode) { _, newValue in
                    addressBinding.wrappedValue.pincode = newValue.filter { $0.isNumber }
                }
                .accessibilityLabel("Pincode")
                .accessibilityHint("Enter a 6-digit postal code")
            
            
            if !addressBinding.wrappedValue.isValidPincode {
                Text("Please enter a valid 6-digit pincode.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .accessibilityLabel("Invalid pincode")
                    .accessibilityValue("Please enter a valid 6-digit pincode.")
                    .accessibilityHint("VoiceOver will read this when the pincode is invalid.")
                    .onAppear {
                        UIAccessibility.post(notification: .announcement, argument: "Please enter a valid 6-digit pincode.")
                    }
            }
            Picker("Address Type", selection: addressBinding.addressType) {
                Text("Work").tag("Work")
                Text("Home").tag("Home")
                Text("Office").tag("Office")
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 4)
            .tint(.primary)
            .font(.subheadline)
            .accessibilityLabel("Select Address Type")
            .accessibilityHint("Choose between Work, Home, or Office")
            
            Button("Save Address") {
                Task { @MainActor in
                    try await user.saveUserData()
                    dismiss()
                }
                
            }
            .disabled(!user.currentUser.canPlaceOrder)
            .accessibilityLabel("Save Delivery Address")
            .accessibilityHint("Tap to save this address")
            .accessibilityValue(user.currentUser.canPlaceOrder ? "Enabled" : "Disabled due to invalid input")
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    let user = DataModel()
    let address = UserAddress(
        name: "order name",
        email: "order@email.com",
        phone: "0000000000",
        city: "Delhicity",
        state: "Delhi",
        country: "India",
        district: "Central",
        street: "123 St",
        pincode: "110001",
        landmark: "Near Metro",
        addressType: "Home"
    )
    
    let sampleUser = User(
        name: "Test User",
        email: "test@email.com",
        phone: "0000000000",
        orders: [],
        address: [address]
    )
    
    user.users.append(sampleUser)
    user.optionalUser = sampleUser

    return NewAddressView(user: user, address: address)
}

