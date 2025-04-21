//
//  PromoCodeView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import SwiftUI

struct PromoCodeView: View {
    @State private var promoCode: String = ""
    @State private var isApplied: Bool = false
    @FocusState private var isFieldFocused: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Enter Promo Code")) {
                    TextField("Promo Code", text: $promoCode)
                        .textInputAutocapitalization(.characters)
                        .disableAutocorrection(true)
                        .focused($isFieldFocused)
                }

                Button {
                    isApplied = true
                    isFieldFocused = false
                    dismiss()
                    //  logic here to validate and apply the code
                } label: {
                    Text("Apply")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(promoCode.isEmpty)
                
                if isApplied {
                    Text("Promo code applied successfully!")
                        .font(.caption)
                        .foregroundColor(.green)
                        .transition(.opacity)
                }
            }
            .navigationTitle("Promo Code")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    PromoCodeView()
}
