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
            TextField("Email", text: addressBinding.email)
                .textContentType(.emailAddress)
            TextField("Phone Number", text: addressBinding.phone)
                .textContentType(.telephoneNumber)
                .foregroundColor(addressBinding.wrappedValue.isValidPhoneNumber ? .primary : .red)
                .onChange(of: addressBinding.wrappedValue.phone) { _, newValue in
                    addressBinding.wrappedValue.phone = newValue.filter { $0.isNumber }
                }
            
            if !addressBinding.wrappedValue.isValidPhoneNumber {
                Text("Please enter a valid 10-digit phone number.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            TextField("Street", text: addressBinding.street, axis: .vertical)
                .textContentType(.fullStreetAddress)
                .autocapitalization(.words)
                .autocorrectionDisabled()
            
            TextField("Landmark", text: addressBinding.landmark)
                .textContentType(.streetAddressLine1)
            TextField("Country", text: addressBinding.country)
                .textContentType(.countryName)
            TextField("State", text: addressBinding.state)
                .textContentType(.addressState)
            TextField("City", text: addressBinding.city)
                .textContentType(.addressCity)
            TextField("District", text: addressBinding.district)
                .textContentType(.sublocality)
            TextField("Pincode", text: addressBinding.pincode)
                .textContentType(.postalCode)
                .keyboardType(.numberPad)
                .foregroundColor(addressBinding.wrappedValue.isValidPincode ? .primary : .red)
                .onChange(of: addressBinding.wrappedValue.pincode) { _, newValue in
                    addressBinding.wrappedValue.pincode = newValue.filter { $0.isNumber }
                }
            
            
            if !addressBinding.wrappedValue.isValidPincode {
                Text("Please enter a valid 6-digit pincode.")
                    .font(.footnote)
                    .foregroundColor(.red)
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
           
            
            Button("Save Address") {
                Task { @MainActor in
                    try await user.saveUserData()
                    dismiss()
                }
               
            }
            .disabled(!user.currentUser.canPlaceOrder)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    let user = DataModel()
    let address = UserAddress(name: "order name", email: "order@email.com", phone: "0000000000", city: "Delhicity", state: "Delhi", country: "India", district: "Central", street: "123 St", pincode: "110001", landmark: "Near Metro", addressType: "Home")
    user.currentUser.address.append(address)
    return NewAddressView(user: user, address: address)
}
