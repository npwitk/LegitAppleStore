//
//  ContentView.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                            .environment(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle("Apple Store")
            .toolbar {
                NavigationLink {
                    CartView()
                        .environment(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
