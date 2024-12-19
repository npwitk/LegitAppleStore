//
//  ProductRow.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 19/12/2024.
//

import SwiftUI

struct ProductRow: View {
    @Environment(CartManager.self) var cartManager
    @State private var isPressed = false
    @State private var showingDeleteConfirmation = false
    
    var product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray.opacity(0.15),
                        Color.gray.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .padding(12)
                    .offset(x: 5)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            // Product Details
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                
                Text("\(product.price.formatted(.currency(code: "THB")))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.secondary)
                
                // Quantity Counter (if needed)
                HStack(spacing: 12) {
                    Label("Quantity: 1", systemImage: "number")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Delete Button
            Button(action: {
                showingDeleteConfirmation = true
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.red)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color.red.opacity(0.1))
                    )
                    .scaleEffect(isPressed ? 0.95 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            .pressEvents(onPress: { pressed in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPressed = pressed
                }
            })
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
        .alert("Remove Item", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Remove", role: .destructive) {
                withAnimation {
                    cartManager.removeFromCart(product: product)
                }
            }
        } message: {
            Text("Are you sure you want to remove this item from your cart?")
        }
    }
}

// Custom button press modifier
struct PressActions: ViewModifier {
    var onPress: (Bool) -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onPress(true) }
                    .onEnded { _ in onPress(false) }
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (Bool) -> Void) -> some View {
        modifier(PressActions(onPress: onPress))
    }
}


#Preview {
    ProductRow(product: productList[3])
        .environment(CartManager())
}
