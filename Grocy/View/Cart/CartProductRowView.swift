//
//  CartProductRowView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//
import SwiftUI

struct CartProductRow: View {
     var observableProduct: ObservableProduct
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass


    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            ProductImage(imageURL: observableProduct.thumbnail)
                .frame(maxWidth: 100, maxHeight: 70)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if isLandscape {
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(observableProduct.name)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                     
                    
                    if observableProduct.isOffer {
                        if let offer = observableProduct.exclusiveOffer {
                            Text("(\(offer.convertedDiscountedPrice) / \(observableProduct.unit))")
                                .font(.headline.italic())
                                .fontWeight(.heavy)
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                            
                        }
                    } else {
                        Text("(\(observableProduct.convertedPrice) / \(observableProduct.unit))")
                            .font(.headline.italic())
                            .fontWeight(.heavy)
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                        
                    }
                }
                .frame(width: 200, alignment: .leading)
                .padding(.horizontal, 10)
                
                
                Spacer()
                VStack(alignment: .leading) {
                    if observableProduct.isOffer {
                        if let offer = observableProduct.exclusiveOffer {
                            let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                            let totalQuantity = Int(observableProduct.quantity) * Int(value)
                            let totalPrice = offer.discountedPrice * Decimal(observableProduct.quantity)
                            
                            Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) - \(totalQuantity) \(unit)")
                                .fontWeight(.bold)
                                .lineLimit(1)
                            
                        }
                    } else {
                        let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                        let totalQuantity = Int(observableProduct.quantity) * Int(value)
                       
                        
                        Text("\(observableProduct.convertedTotalPrice) - \(totalQuantity) \(unit)")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                    }
                    
                    CartQuantityControlview(observableProduct: observableProduct, animateChange: $animateChange, cartProducts: cartProducts)
                    
                }
                .padding(.horizontal, 10)
                
            } else {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(observableProduct.name)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                    
                    if observableProduct.isOffer {
                        if let offer = observableProduct.exclusiveOffer {
                            Text("(\(offer.convertedDiscountedPrice) / \(observableProduct.unit))")
                                .font(.caption2.italic())
                                .fontWeight(.heavy)
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                            
                            let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                            let totalQuantity = Int(observableProduct.quantity) * Int(value)
                            let totalPrice = offer.discountedPrice * Decimal(observableProduct.quantity)
                            
                            Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) -  \(totalQuantity) \(unit)")
                                .font(.subheadline.bold())
                                .lineLimit(1)
                        }
                    } else {
                        
                        Text("(\(observableProduct.convertedPrice) / \(observableProduct.unit))")
                            .font(.caption2.italic())
                            .fontWeight(.heavy)
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                        
                        let (value, unit) = observableProduct.parsedUnit ?? (1, "unit")
                        let totalQuantity = Int(observableProduct.quantity) * Int(value)
                       
                        
                        Text("\(observableProduct.convertedTotalPrice) -  \(totalQuantity) \(unit)")
                            .font(.subheadline.bold())
                            .lineLimit(1)
                    }
                    
                  
                        CartQuantityControlview(observableProduct: observableProduct, animateChange: $animateChange, cartProducts: cartProducts)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(1)
                
                
                
            }
            VStack(alignment: .trailing) {
                Button {
                    cartProducts.removeProductFromCart(product: observableProduct)
                    
                } label: {
                    Image(systemName: "trash")
                        .font(.subheadline)
                }
                .buttonStyle(.borderless)
                .padding([.top,.trailing], 20)
                .foregroundStyle(.red)
                .accessibilityLabel("Remove \(observableProduct.name)")
               
               Spacer()
            }
            .padding(0)
          
           
           
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .scaleEffect(animateChange.contains(observableProduct.id) ? 1.04 : 1.0)
        .opacity(animateChange.contains(observableProduct.id) ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: animateChange)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(observableProduct.name))
        .accessibilityValue(Text("Quantity \(observableProduct.quantity), Total price \(observableProduct.convertedTotalPrice)"))
        .accessibilityHint("Double tap to remove or change quantity.")
    }
}

#Preview {
    CartProductRow(observableProduct: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
