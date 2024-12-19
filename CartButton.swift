//
//  CartButton.swift
//  LegitAppleStore
//
//  Created by Nonprawich I. on 18/12/2024.
//

import SwiftUI

struct CartButton: View {
    
    var numberOfProducts: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 5)
                .padding(.trailing, 5)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .cornerRadius(50)
            }
        }
    }
}

#Preview {
    CartButton(numberOfProducts: 2)
}
