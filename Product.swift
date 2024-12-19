//
//  Product.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [
    Product(name: "Acey Mac", image: "Apple_AceyMac", price: 137),
    Product(name: "Autumn Crisp", image: "Apple_Autumn_Crisp", price: 189),
    Product(name: "Cameo", image: "Apple_Cameo", price: 157),
    Product(name: "Crispin", image: "Apple_Crispin", price: 231),
    Product(name: "Fortune", image: "Apple_Fortune", price: 145),
    Product(name: "Fuji", image: "Apple_Fuji", price: 173),
    Product(name: "Granny Smith", image: "Apple_GrannySmith", price: 200),
    Product(name: "Honeycrisp", image: "Apple_Honeycrisp", price: 219),
    Product(name: "Idared", image: "Apple_Idared", price: 150),
]

