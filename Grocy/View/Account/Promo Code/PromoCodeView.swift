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
                        .accessibilityLabel("Promo Code Text Field")
                        .accessibilityHint("Enter your promo code here")
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
                .accessibilityLabel("Apply Promo Code Button")
                .accessibilityHint("Tap to apply the promo code")
                
                if isApplied {
                    Text("Promo code applied successfully!")
                        .font(.caption)
                        .foregroundColor(.green)
                        .transition(.opacity)
                        .accessibilityLabel("Promo Code Applied")
                        .accessibilityValue("Promo code applied successfully!")
                }
            }
            .navigationTitle("Promo Code")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFieldFocused = false
                    }
                    .accessibilityLabel("Done Button")
                    .accessibilityHint("Dismiss the keyboard")
                }
            }
        }
    }
}

#Preview {
    PromoCodeView()
}
