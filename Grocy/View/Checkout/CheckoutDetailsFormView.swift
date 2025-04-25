//
//  CheckoutDetailsFormView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import SwiftUI

enum Field: Hashable {
    case name, email, phone, street, landmark, country, state, city, district, pincode, addressType
}


struct CheckoutDetailsFormView: View {
    @Bindable var user: DataModel
    @FocusState.Binding var focusedField: Field?
    
    
    var body: some View {
        let addressBinding = Binding<UserAddress>(
            get: { user.currentUser.primaryAddress },
            set: { user.currentUser.primaryAddress = $0 }
        )
        
        Group {
            Section {
                
                TextField("Your Name", text: addressBinding.name)
                    .textContentType(.name)
                    .focused($focusedField, equals: .name)
                    .accessibilityLabel("Your name")
                    .accessibilityValue(addressBinding.wrappedValue.name)
                    .accessibilityHint("Enter your full name")
                TextField("Email Address", text: addressBinding.email)
                    .textContentType(.emailAddress)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                    .accessibilityLabel("Email address")
                    .accessibilityValue(addressBinding.wrappedValue.email)
                    .accessibilityHint("Enter a valid email address")
                
                TextField("Phone Number", text: addressBinding.phone)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                    .autocapitalization(.none)
                    .foregroundColor(addressBinding.wrappedValue.isValidPhoneNumber ? .primary : .red)
                    .onChange(of: addressBinding.wrappedValue.phone) { _, newValue in
                        addressBinding.wrappedValue.phone = newValue.filter { $0.isNumber }
                    }
                    .focused($focusedField, equals: .phone)
                    .accessibilityLabel("Phone number")
                    .accessibilityValue(addressBinding.wrappedValue.phone)
                    .accessibilityHint("Enter a valid 10-digit phone number")
                
                if !addressBinding.wrappedValue.isValidPhoneNumber {
                    Text("Please enter a valid 10-digit phone number.")
                        .foregroundColor(.red)
                        .font(.footnote)
                        .accessibilityLabel("Invalid phone number")
                        .accessibilityHint("Phone number should be 10 digits long")
                }
                
            }header: {
                Text("Personal Details")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .accessibilityLabel("Personal details section")
            }
            
            Section {
                
                TextField("Street", text: addressBinding.street, axis: .vertical)
                    .textContentType(.fullStreetAddress)
                    .autocapitalization(.words)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .street)
                    .accessibilityLabel("Street address")
                    .accessibilityValue(addressBinding.wrappedValue.street)
                
                
                
                TextField("landmark", text: addressBinding.landmark)
                    .textContentType(.streetAddressLine1)
                    .focused($focusedField, equals: .landmark)
                    .accessibilityLabel("Landmark")
                    .accessibilityValue(addressBinding.wrappedValue.landmark)
                
                TextField("Country", text: addressBinding.country)
                    .textContentType(.countryName)
                    .focused($focusedField, equals: .country)
                    .accessibilityLabel("Country")
                    .accessibilityValue(addressBinding.wrappedValue.country)
                
                TextField("State", text: addressBinding.state)
                    .textContentType(.addressState)
                    .focused($focusedField, equals: .state)
                    .accessibilityLabel("State")
                    .accessibilityValue(addressBinding.wrappedValue.state)
                
                TextField("City", text: addressBinding.city)
                    .textContentType(.addressCity)
                    .focused($focusedField, equals: .city)
                    .accessibilityLabel("City")
                    .accessibilityValue(addressBinding.wrappedValue.city)
                
                TextField("District", text: addressBinding.district)
                    .textContentType(.sublocality)
                    .focused($focusedField, equals: .district)
                    .accessibilityLabel("District")
                    .accessibilityValue(addressBinding.wrappedValue.district)
                
                TextField("Pincode", text: addressBinding.pincode)
                    .textContentType(.postalCode)
                    .keyboardType(.numberPad)
                    .foregroundColor(addressBinding.wrappedValue.isValidPincode ? .primary : .red)
                    .onChange(of: addressBinding.wrappedValue.pincode) { _, newValue in
                        addressBinding.wrappedValue.pincode = newValue.filter { $0.isNumber }
                    }
                    .focused($focusedField, equals: .pincode)
                    .accessibilityLabel("Pincode")
                    .accessibilityValue(addressBinding.wrappedValue.pincode)
                
                if !addressBinding.wrappedValue.isValidPincode {
                    Text("Please enter a valid 6-digit pincode.")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .accessibilityLabel("Invalid pincode")
                        .accessibilityHint("Pincode should be 6 digits long")
                }
                
                Picker("Address Type", selection: addressBinding.addressType) {
                    Text("Work").tag("Work")
                    Text("Home").tag("Home")
                    Text("Office").tag("Office")
                }
                .pickerStyle(.menu)
                .tint(.primary)
                .font(.subheadline)
                .accessibilityLabel("Address type")
                .accessibilityValue(addressBinding.wrappedValue.addressType)
                
                
            }header: {
                Text("Delivery Address")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .accessibilityLabel("Delivery address section")
            }
            
        }
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var user = DataModel()
        @FocusState private var focusedField: Field?

        var body: some View {
            CheckoutDetailsFormView(user: .preview, focusedField: $focusedField)
                .onAppear {
                    focusedField = .city
                }
        }
    }

    return PreviewWrapper()
}
