//
//  HomeViewModel.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable

    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "AppleWatch"),
        Product(type: .Tablets, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Tablet"),
        Product(type: .Laptops, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Laptop"),
        Product(type: .Phones, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Phone"),

    ]

    // Filtered Products
    @Published var filteredProducts: [Product] = []

    //More products on the type...
    @Published var showMoreProductsOnType: Bool = false

    init() {
        filterProductByType()
    }

    func filterProductByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}
