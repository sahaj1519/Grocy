//
//  CartProductRowView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 14/04/25.
//
import SwiftUI

struct CartProductRow: View {
    var product: Product
    @Binding var animateChange: Set<UUID>
    @Bindable var cartProducts: Cart
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            ProductImage(imageURL: product.thumbnail)
                .frame(maxWidth: 120, maxHeight: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if isLandscape {
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                    
                    
                    if product.isOffer {
                        if let offer = product.exclusiveOffer {
                            Text("(\(offer.convertedDiscountedPrice) / \(product.unit))")
                                .font(.headline.italic())
                                .fontWeight(.heavy)
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                            
                        }
                    } else {
                        Text("(\(product.convertedPrice) / \(product.unit))")
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
                    if product.isOffer {
                        if let offer = product.exclusiveOffer {
                            let (value, unit) = product.parsedUnit ?? (1, "unit")
                            let totalQuantity = Int(product.quantity) * Int(value)
                            let totalPrice = offer.discountedPrice * Decimal(product.quantity)
                            
                            Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) - \(totalQuantity) \(unit)")
                                .fontWeight(.bold)
                                .lineLimit(1)
                            
                        }
                    } else {
                        let (value, unit) = product.parsedUnit ?? (1, "unit")
                        let totalQuantity = Int(product.quantity) * Int(value)
                       
                        
                        Text("\(product.convertedTotalPrice) - \(totalQuantity) \(unit)")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                    }
                    
                    CartQuantityControlview(product: product, animateChange: $animateChange, cartProducts: cartProducts)
                    
                }
                .padding(.horizontal, 10)
                
            } else {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(product.name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                    
                    if product.isOffer {
                        if let offer = product.exclusiveOffer {
                            Text("(\(offer.convertedDiscountedPrice) / \(product.unit))")
                                .font(.subheadline.italic())
                                .fontWeight(.heavy)
                                .lineLimit(1)
                                .foregroundStyle(.secondary)
                            
                            let (value, unit) = product.parsedUnit ?? (1, "unit")
                            let totalQuantity = Int(product.quantity) * Int(value)
                            let totalPrice = offer.discountedPrice * Decimal(product.quantity)
                            
                            Text("\(totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) -  \(totalQuantity) \(unit)")
                                .fontWeight(.bold)
                                .lineLimit(1)
                        }
                    } else {
                        
                        Text("(\(product.convertedPrice) / \(product.unit))")
                            .font(.subheadline.italic())
                            .fontWeight(.heavy)
                            .lineLimit(1)
                            .foregroundStyle(.secondary)
                        
                        let (value, unit) = product.parsedUnit ?? (1, "unit")
                        let totalQuantity = Int(product.quantity) * Int(value)
                       
                        
                        Text("\(product.convertedTotalPrice) -  \(totalQuantity) \(unit)")
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                    
                    CartQuantityControlview(product: product, animateChange: $animateChange, cartProducts: cartProducts)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(1)
                
                
                
            }
            VStack(alignment: .trailing) {
                Button {
                    cartProducts.removeProductFromCart(product: product)
                    
                } label: {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
                .padding([.top,.trailing], 20)
                .foregroundStyle(.red)
                
                
               Spacer()
            }
            .padding(0)
          
           
           
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .scaleEffect(animateChange.contains(product.id) ? 1.04 : 1.0)
        .opacity(animateChange.contains(product.id) ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: animateChange)
    }
}

#Preview {
    CartProductRow(product: .example, animateChange: .constant([UUID()]), cartProducts: .example)
}
