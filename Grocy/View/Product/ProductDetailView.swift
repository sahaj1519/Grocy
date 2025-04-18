//
//  ProductDetailView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    var cart: Cart
    @State private var showAddedOverlay = false
    @State private var isPressed = false
    @State var animateChange: Set<UUID> = []
    @State private var animateDetails = false
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack(alignment: .topLeading) {
                        ProductImage(imageURL: product.thumbnail)
                            .frame(maxWidth: .infinity)
                            .ignoresSafeArea(edges: .top)
                            .blur(radius: 100)
                            .frame(height: 200)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.easeIn(duration: 1), value: animateDetails)
                        
                        if product.isOffer {
                            OfferRibbon(product: product, text: "OFFER", font: .headline, fontWeight: .bold, foregroundColor: .white.opacity(0.9), backgroundColor: .red.opacity(0.7), shape: AnyShape(RoundedRectangle(cornerRadius: 10)), rotation: 0, offsetX: -10, offsetY: +270, shadowRadius: 3.0)
                                .padding(.top, 6)
                                .padding(.leading, 6)
                                .offset(x: +22, y: -5)
                                .zIndex(1)
                        }
                        
                        TabView {
                            ForEach(product.images, id: \.self) {image in
                                ProductImage(imageURL: image)
                                    .frame(maxWidth: .infinity)
                                    .transition(.opacity.combined(with: .scale))
                                
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .frame(height: 300)
                        
                        
                        
                    }
                }
               
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.2), value: animateDetails)
                    
                    HStack {
                        Text("Category:")
                            .font(.headline.bold())
                        Text("\(product.category)")
                            .font(.body)
                        
                    }
                    .opacity(animateDetails ? 1 : 0)
                    .offset(y: animateDetails ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.3), value: animateDetails)
                    
                    
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("Price:")
                            .font(.headline.bold())
                        VStack {
                            ProductPriceAndCartButtonView(product: product, cart: cart, showOverlay: $showAddedOverlay, isPressed: $isPressed)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 0)
                                .scaleEffect(isPressed ? 1.1 : 1.0)
                                .animation(.spring(), value: isPressed)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 0)
                        }
                    }
                    .opacity(animateDetails ? 1 : 0)
                    .offset(y: animateDetails ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.4), value: animateDetails)
                    
                    Text("Description: ")
                        .font(.headline.bold())
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
                    
                    Text(product.description)
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
                    
                    Text("Source: ")
                        .font(.headline.bold())
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.5), value: animateDetails)
                    
                    
                    Text(product.source)
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.6), value: animateDetails)
                }
                .padding()
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .onAppear {
                animateDetails = true
            }
            .background(.green.opacity(0.1))
            if showAddedOverlay {
                VStack {
                    Spacer()
                    Text("✓ Added to Cart!")
                        .font(.headline.bold())
                        .foregroundStyle(.green)
                        .scaleEffect(showAddedOverlay ? 1 : 0.5)
                        .opacity(showAddedOverlay ? 1 : 0)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .move(edge: .bottom)).combined(with: .opacity),
                            removal: .opacity
                        ))
                        .padding(.bottom, 50)
                }
                .zIndex(2)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showAddedOverlay)
            }

        }
        
    }
}

#Preview {
    ProductDetailView(product: .example, cart: .example, animateChange: [UUID()])
}
