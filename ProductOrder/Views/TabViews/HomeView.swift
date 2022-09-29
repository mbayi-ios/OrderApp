//
//  HomeView.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI

struct HomeView: View {
    @Namespace var animation

    @StateObject var homeData: HomeViewModel = HomeViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)

                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)

                Text("Order Online\ncollect in store")
                    .font(.custom("Raleway-Bold", size: 28))
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Products Tab
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            // Product Type View...
                            ProductTypeView(type: type)

                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts) { product in
                            // product card view
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)

                // see more button to show all the products on the current type
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See more")
                    }
                    .font(.custom("Raleway-Regular", size: 15).bold())
                    .foregroundColor(Color.purple)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)


            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        //updating data whenever tab changes
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {

        } content:  {
            MoreProductsView()
        }
    }

    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height:  getRect().width / 2.5)

            //moving image offset
                .offset(y: -80)
                .padding(.bottom, -80)

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

    }

    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button {
            // updating current type
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom("Raleway-Regular", size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color.purple : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    // Adding matched geormety effect

                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color.purple)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom
                )

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
