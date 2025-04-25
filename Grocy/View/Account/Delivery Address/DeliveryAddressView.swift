//
//  DeliveryAddressView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct DeliveryAddressView: View {
    @Bindable var user: DataModel
    @State private var selectedAddress: UserAddress? = nil
    
   
    func deleteAddress(_ address: UserAddress) {
        if let index = user.currentUser.address.firstIndex(where: { $0.id == address.id }) {
            user.currentUser.address.remove(at: index)
        }
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                if user.currentUser.address.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Label("No Delivery Address", systemImage: "map.fill")
                        },
                        description: {
                            Text("Please add a delivery address to proceed with your orders.")
                        },
                        actions: {
                            Button {
                                selectedAddress = UserAddress(
                                    name: "", email: "", phone: "",
                                    city: "", state: "", country: "",
                                    district: "", street: "", pincode: "", landmark: "", addressType: "Home"
                                )
                            } label: {
                                Label("Add Address", systemImage: "plus")
                            }
                            .buttonStyle(.borderedProminent)
                            .accessibilityLabel("Add New Address")
                            .accessibilityHint("Adds a new delivery address")
                            .accessibilityAddTraits(.isButton)
                        }
                    )
                    .padding()
                } else {
                    VStack(spacing: 16) {
                        ForEach(user.currentUser.address) { address in
                            ZStack(alignment: .topTrailing) {
                                Button {
                                    selectedAddress = address
                                } label: {
                                    VStack(alignment: .leading, spacing: 10) {
                                        LabelView(label: "Type", value: address.addressType)
                                        LabelView(label: "Name", value: address.name)
                                        LabelView(label: "Email", value: address.email)
                                        LabelView(label: "Phone", value: address.phone)
                                        LabelView(label: "Landmark", value: address.landmark)
                                        LabelView(label: "District", value: address.district)
                                        LabelView(label: "City", value: address.city)
                                        LabelView(label: "State", value: address.state)
                                        LabelView(label: "Country", value: address.country)
                                        LabelView(label: "Pincode", value: address.pincode)
                                        
                                    }
                                    .padding(16)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.regularMaterial)
                                    )
                                    .padding(.horizontal)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityLabel("Address for \(address.name)")
                                    .accessibilityHint("Double tap to edit this address")
                                    
                                }
                                .tint(.primary)
                                
                                
                                Button {
                                    deleteAddress(address)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                        .accessibilityLabel("Delete Address")
                                        .accessibilityHint("Deletes this saved address")
                                        .accessibilityAddTraits(.isButton)

                                }
                                .offset(x: -20)
                            }
                        }
                        
                    }
                    .padding(.vertical)
                }
                
            }
            .sheet(item: $selectedAddress, onDismiss: {
                selectedAddress = nil
            }) { address in
                NewAddressView(user: user, address: address)
            }
            .navigationTitle("Your Address")
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem {
                    Button {
                        selectedAddress = UserAddress(name: "", email: "", phone: "", city: "", state: "", country: "", district: "", street: "", pincode: "", landmark: "", addressType: "Home")
                    } label: {
                        Image(systemName: "plus")
                            .accessibilityLabel("Add New Address")
                            .accessibilityHint("Adds a new delivery address")
                            .accessibilityAddTraits(.isButton)
                    }
                }
            }
        }
    }
}

#Preview {
    DeliveryAddressView(user: .preview)
}
