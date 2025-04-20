//
//  CheckoutDetailsFormView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 18/04/25.
//

import SwiftUI

enum Field: Hashable {
    case name, email, phone, street, landmark, country, state, city, district, pincode
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
                TextField("Email Address", text: addressBinding.email)
                    .textContentType(.emailAddress)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                
                TextField("Phone Number", text: addressBinding.phone)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                    .autocapitalization(.none)
                    .foregroundColor(addressBinding.wrappedValue.isValidPhoneNumber ? .primary : .red)
                    .onChange(of: addressBinding.wrappedValue.phone) { _, newValue in
                        addressBinding.wrappedValue.phone = newValue.filter { $0.isNumber }
                    }
                    .focused($focusedField, equals: .phone)
                
                if !addressBinding.wrappedValue.isValidPhoneNumber {
                    Text("Please enter a valid 10-digit phone number.")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
            }header: {
                Text("Personal Details")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            Section {
               
                TextField("Street", text: addressBinding.street, axis: .vertical)
                    .textContentType(.fullStreetAddress)
                    .autocapitalization(.words)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .street)
                
                
                TextField("landmark", text: addressBinding.landmark)
                    .textContentType(.streetAddressLine1)
                    .focused($focusedField, equals: .landmark)
                
                TextField("Country", text: addressBinding.country)
                    .textContentType(.countryName)
                    .focused($focusedField, equals: .country)
                
                TextField("State", text: addressBinding.state)
                    .textContentType(.addressState)
                    .focused($focusedField, equals: .state)
                
                TextField("City", text: addressBinding.city)
                    .textContentType(.addressCity)
                    .focused($focusedField, equals: .city)
                
                TextField("District", text: addressBinding.district)
                    .textContentType(.sublocality)
                    .focused($focusedField, equals: .district)
                
                TextField("Pincode", text: addressBinding.pincode)
                    .textContentType(.postalCode)
                    .keyboardType(.numberPad)
                    .foregroundColor(addressBinding.wrappedValue.isValidPincode ? .primary : .red)
                    .onChange(of: addressBinding.wrappedValue.pincode) { _, newValue in
                        addressBinding.wrappedValue.pincode = newValue.filter { $0.isNumber }
                    }
                    .focused($focusedField, equals: .pincode)
                
                if !addressBinding.wrappedValue.isValidPincode {
                    Text("Please enter a valid 6-digit pincode.")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                
            }header: {
                Text("Delivery Address")
                    .font(.subheadline)
                    .foregroundColor(.primary)
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
