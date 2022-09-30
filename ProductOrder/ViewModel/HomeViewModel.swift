//
//  HomeViewModel.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI
import Combine

//using combine to monitor search field

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable

    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Watch-1"),
        Product(type: .Wearable, title: "Tablet", subtitle: "Series 6: Red", price: "$359", productImage: "Watch-2"),
        Product(type: .Wearable, title: "Table", subtitle: "Series 6: Red", price: "$359", productImage: "Watch-3"),
        Product(type: .Tablets, title: "Apple", subtitle: "Series 6: Red", price: "$359", productImage: "Tablet"),
        Product(type: .Laptops, title: "Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Laptop"),
        Product(type: .Phones, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "Phone"),

    ]

    // Filtered Products
    @Published var filteredProducts: [Product] = []

    //More products on the type...
    @Published var showMoreProductsOnType: Bool = false

    //search data
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?

    var searchCancellable: AnyCancellable?

    init() {
        filterProductByType()

        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
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

    func filterProductBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }

            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }

}
