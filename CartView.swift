//
//  CartView.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import SwiftUI

struct CartView: View {
    @Environment(CartManager.self) var cartManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                if cartManager.paymentSuccess {
                    paymentSuccessView
                } else {
                    mainCartContent
                }
            }
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                if cartManager.paymentSuccess {
                    cartManager.paymentSuccess = false
                }
            }
        }
    }
    private var paymentSuccessView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
                .symbolEffect(.bounce)
            
            VStack(spacing: 12) {
                Text("Thank You!")
                    .font(.title2.bold())
                
                Text("Your purchase was successful.\nYou'll get an apple soon.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            
            Button(action: {
                dismiss()
            }) {
                Text("Continue Shopping")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    
    private var mainCartContent: some View {
        VStack(spacing: 16) {
            if cartManager.products.isEmpty {
                ContentUnavailableView(
                    "Your Cart is Empty",
                    systemImage: "cart.badge.minus",
                    description: Text("Items you add to your cart will appear here.")
                )
                .symbolRenderingMode(.multicolor)
            } else {
                VStack(spacing: 16) {
                
                    VStack(spacing: 12) {
                        ForEach(cartManager.products, id: \.id) { product in
                            ProductRow(product: product)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        Text("Order Summary")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Subtotal")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("\(cartManager.total.formatted(.currency(code: "THB")))")
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("Shipping")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("Free")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.green)
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Total")
                                    .font(.title3.bold())
                                Spacer()
                                Text("\(cartManager.total.formatted(.currency(code: "THB")))")
                                    .font(.title3.bold())
                            }
                        }
                        
                        PaymentButton(action: cartManager.pay)
                            .padding(.top, 8)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}


#Preview {
    CartView()
        .environment(CartManager())
}

#Preview("Cart with Items") {
    NavigationStack {
        CartView()
            .environment({
                let manager = CartManager()
                manager.products = Array(productList.prefix(3))
                return manager
            }())
    }
}

#Preview("Payment Success") {
    NavigationStack {
        CartView()
            .environment({
                let manager = CartManager()
                manager.paymentSuccess = true
                return manager
            }())
    }
}
