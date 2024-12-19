//
//  CartManager.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import Foundation

@Observable
class CartManager {
    var products: [Product] = []
    private(set) var total: Int = 0
    
    let paymentHandler = PaymentHandler()
    var paymentSuccess = false
    
    func addToCart(product: Product) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Product) {
        if let removeProduct = products.firstIndex(where: {$0.id == product.id}) {
            products.remove(at: removeProduct)
        }
        total -= product.price
    }
    
    func pay() {
        paymentHandler.startPayment(products: products, total: total) { success in
            self.paymentSuccess = success
            self.products = []
            self.total = 0
        }
    }
}
