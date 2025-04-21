//
//  AllProfileRows.swift
//  Grocy
//
//  Created by Ajay Sangwan on 20/04/25.
//

import SwiftUI

struct AllProfileRows: View {
    @Bindable var user: DataModel
    
    var body: some View {
        
        ProfileRowView(systemImage: "shippingbox", title: "Orders", destination: ProfileOrderView(user: user))
        
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: .infinity, maxHeight: 1)
        
        ProfileRowView(systemImage: "person.text.rectangle", title: "My Details", destination: MyDetailsView(user: user))
        
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: .infinity, maxHeight: 1)
        
        ProfileRowView(systemImage: "location", title: "Delivery Address", destination: DeliveryAddressView(user: user))
        
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: .infinity, maxHeight: 1)
        ProfileRowView(systemImage: "creditcard", title: "Payment Methods", destination: PaymentMethodsView())
        
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: .infinity, maxHeight: 1)
        
        ProfileRowView(systemImage: "gift", title: "Promo Code", destination: PromoCodeView())
        
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}

#Preview {
    AllProfileRows(user: DataModel())
}
