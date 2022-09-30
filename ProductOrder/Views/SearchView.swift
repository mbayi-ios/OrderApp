//
//  SearchView.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID

    @EnvironmentObject var sharedData: SharedDataModel

    @EnvironmentObject var homeData: HomeViewModel

    //activating text field with the help of focusState
    @FocusState var startTF: Bool
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                // search bar
                HStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)

                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.purple, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)

            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)

            if let products = homeData.searchedProducts {
                if products.isEmpty {

                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .padding(.top, 60)

                        Text("Item Not Found")
                            .font(.custom("Raleway", size: 22).bold())

                        Text("Try a more generic search term or try looking for alternative products")
                            .font(.custom("Raleway", size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()

                } else {
                    // filter results
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            Text("Found \(products.count) results")
                                .font(.custom("Raleway-Regular", size: 24))
                                .padding(.vertical)
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                ProductCardView(product: product)
                            }

                        }
                        .padding()
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }

    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            .offset(y: -50)
            .padding(.bottom, -50)

            Text(product.title)
                .font(.custom("Raleway-Regular", size: 18))
                .fontWeight(.semibold)
                .padding(.top)

            Text(product.subtitle)
                .font(.custom("Raleway-Regular", size: 14))
                .foregroundColor(.gray)

            Text(product.price)
                .font(.custom("Raleway-Regular", size: 16))
                .foregroundColor(Color.purple)
                .fontWeight(.bold)
                .padding(.top,5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
