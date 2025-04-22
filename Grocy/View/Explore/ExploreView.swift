//
//  ExploreView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(\.isPresented) private var isPresented

    @Binding var observableProducts: [ObservableProduct]
    @Bindable var cart: Cart
    
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    @State private var showAllProducts = false

     var favoriteProducts: Favorite
    
    var filter: ((ObservableProduct) -> Bool)? = nil
    var filterTitle: String?

   
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 5),
        GridItem(.adaptive(minimum: 120), spacing: 5),
        GridItem(.adaptive(minimum: 120), spacing: 5)
    ]
    
    let categoryColumns = [
        GridItem(.adaptive(minimum: 150), spacing: 15),
       
    ]
    
    var uniqueCategories: [CategoryInfo] {
        let categoryNames = Set(observableProducts.map { $0.category.lowercased() })
        return CategoryLibrary.all.filter { categoryNames.contains($0.name.lowercased()) }
    }



    var filterProducts: [ObservableProduct] {
        var base: [ObservableProduct] = observableProducts
        
        if let filter = filter {
            base = base.filter(filter)
        }
        
        if !showAllProducts, let selected = selectedCategory {
            base = base.filter { $0.category == selected }
        }
        
        if !searchText.isEmpty {
            base = base.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        return base
    }


    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                if searchText.isEmpty && selectedCategory == nil && !showAllProducts && filter == nil {
                    LazyVGrid(columns: categoryColumns, spacing: 15) {
                        ForEach(uniqueCategories) { category in
                            CategoryGridView(
                                category: category
                            ) {
                                selectedCategory = category.name
                                searchText = ""
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 15)
                }
                
                
                if let category = selectedCategory {
                    HStack {
                        Text("Showing: \(category)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Button {
                            selectedCategory = nil
                        } label: {
                            Label("Clear", systemImage: "xmark.circle")
                            
                        }
                        .font(.footnote)
                    }
                    .padding(.horizontal)
                }
                
                if selectedCategory != nil || !searchText.isEmpty || showAllProducts || filter != nil {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(filterProducts) { product in
                            NavigationLink(value: product) {
                                
                                SingleProductView(observableProduct: product, cart: cart, favoriteProducts: favoriteProducts)
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    .tint(.primary)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationDestination(for: ObservableProduct.self) { product in
                ProductDetailView(observableProduct: product, cart: cart)
            }
            .background(.green.opacity(0.05))
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(filterTitle ?? "Find Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !isPresented {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !showAllProducts && selectedCategory == nil && searchText.isEmpty {
                            Button {
                                showAllProducts = true
                            } label: {
                                Label("All Products", systemImage: "square.grid.3x3")
                            }
                        } else if showAllProducts {
                            Button {
                                showAllProducts = false
                                selectedCategory = nil
                                searchText = ""
                            } label: {
                                Label("Category", systemImage: "rectangle.3.offgrid")
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}


#Preview {
    ExploreView(
        observableProducts: .constant([.example]),
        cart: .example,
        favoriteProducts: .example)
}
