//
//  ProductCard.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import SwiftUI

struct ProductCard: View {
    @Environment(CartManager.self) var cartManager
    @State private var isHovered = false
    @State private var showingAddedAnimation = false
    
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {

            ZStack(alignment: .bottom) {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.gray.opacity(0.2),
                            Color.gray.opacity(0.1)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    Image(product.image)
                        .resizable()
                        .offset(x: 8, y: -25)
                        .scaledToFit()
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .scaleEffect(isHovered ? 1.05 : 1.0)
                        .animation(.spring(dampingFraction: 0.7), value: isHovered)
                }
                .cornerRadius(20)
                
                VStack(spacing: 8) {
                    Text(product.name)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Text("\(product.price.formatted(.currency(code: "THB")))")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(width: 180)
                .background(.ultraThinMaterial)
                .background(
                    Color.white.opacity(0.7)
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
            }
            .frame(width: 180, height: 250)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
            .onHover { hovering in
                isHovered = hovering
            }
            
            Button {
                withAnimation(.spring(dampingFraction: 0.7)) {
                    showingAddedAnimation = true
                    cartManager.addToCart(product: product)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showingAddedAnimation = false
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 36, height: 36)
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 3)
                    
                    Image(systemName: showingAddedAnimation ? "checkmark" : "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .scaleEffect(showingAddedAnimation ? 1.2 : 1.0)
                }
            }
            .padding(12)
            .scaleEffect(isHovered ? 1.1 : 1.0)
            .animation(.spring(dampingFraction: 0.7), value: isHovered)
        }
    }
}


#Preview {
    ProductCard(product: productList[0])
        .environment(CartManager())
}
