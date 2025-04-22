//
//  ProductDetailView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 16/04/25.
//

import SwiftUI

struct ProductDetailView: View {
    @Bindable var observableProduct: ObservableProduct
    var cart: Cart
    @State private var showAddedOverlay = false
    @State private var isPressed = false
    @State var animateChange: Set<UUID> = []
    @State private var animateDetails = false
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack(alignment: .top) {
                        ProductImage(imageURL: observableProduct.thumbnail)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .ignoresSafeArea(edges: .top)
                            .blur(radius: 100)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.easeIn(duration: 1), value: animateDetails)
                        
                        if observableProduct.isOffer {
                            OfferRibbon(observableProduct: observableProduct,showText: "off", text: "OFFER", font: .headline, fontWeight: .bold, foregroundColor: .white, backgroundColor: .red, shape: AnyShape(Capsule()), rotation: 0, offsetX: -10, offsetY: +270, shadowRadius: 2.0)
                                .padding(.top, 6)
                                .padding(.leading, 6)
                                .offset(x: -140, y: -45)
                                .zIndex(1)
                            
                            if  observableProduct.isOffer {
                                OfferCountDown(observableProduct: observableProduct)
                                    .padding(.top, 4)
                                    .padding(.leading, 6)
                                    .offset(x: +100, y: +230)
                                    .zIndex(1)
                            }

                        }
                        
                        TabView {
                            ForEach(observableProduct.images, id: \.self) {image in
                                ProductImage(imageURL: image)
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                                    .transition(.opacity.combined(with: .scale))
                                    
                                
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .frame(height: 250)
                        
                    }
                }
               
                VStack(alignment: .leading, spacing: 8) {
                    Text(observableProduct.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(animateDetails ? 1 : 0)
                        .offset(y: animateDetails ? 0 : 20)
                        .animation(.easeOut(duration: 0.6).delay(0.2), value: animateDetails)
                    
                    HStack {
                        Text("Category:")
                            .font(.subheadline.bold())
                        Text("\(observableProduct.category)")
                            .font(.subheadline)
                        
                    }
                    .opacity(animateDetails ? 1 : 0)
                    .offset(y: animateDetails ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.3), value: animateDetails)
                    
                    
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("Price:")
                            .font(.subheadline.bold())
                        VStack {
                            ProductPriceAndCartButtonView(observableProduct: observableProduct, cart: cart, showOverlay: $showAddedOverlay, isPressed: $isPressed)
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
                    
                    DetailsRow(animateDetails: $animateDetails, observableProduct: observableProduct)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .scrollBounceBehavior(.always)
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
    ProductDetailView(observableProduct: ObservableProduct(product: .example), cart: .example, animateChange: [UUID()])
}
