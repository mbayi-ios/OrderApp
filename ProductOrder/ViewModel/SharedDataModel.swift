//
//  SharedDataModel.swift
//  ProductOrder
//
//  Created by Amby on 30/09/2022.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    // detail product data

    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false

    //matched Geomtry effect from search page
    @Published var fromSearchPage: Bool = false

    // liked products
    @Published var likedProducts: [Product] = []

    // basket products
    @Published var cartProducts: [Product] = []

    // caluclating total price ...

    func getTotalPrice() -> String {
        var total: Int = 0

        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue

            total += priceTotal
        }
        return "$\(total)"
    }
}

