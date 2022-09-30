//
//  ProductDetailView.swift
//  ProductOrder
//
//  Created by Amby on 30/09/2022.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product

    //For matched geometry effect...
    var animation: Namespace.ID


    //shared Data Model
    @EnvironmentObject var sharedData: SharedDataModel
    var body: some View {
        VStack {
            // title bar and product image
            VStack {
                // title bar
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()

                    Button {

                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                    }


                }
                .padding()

                // product Image
                // adding matched geometry effect...

                Image(product.productImage)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxWidth: .infinity)

            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)

            // product details
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.custom("Raleway-SemiBold", size: 22))

                    Text(product.title)
                        .font(.custom("Raleway-Regular", size: 18))
                        .foregroundColor(.gray)

                    Text("Get Apple Tv+ free for a year")
                        .font(.custom("Raleway-Regular", size: 18))
                        .padding(.top)

                    Text("Available when you purchase any new iphone.")
                        .font(.custom("Raleway-Regular", size: 15))
                        .foregroundColor(.gray)

                    Button {

                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom("Raleway-Regular", size: 15))
                        .foregroundColor(Color.purple)
                    }
                    HStack {
                        Text("Total")
                            .font(.custom("Raleway-Regular", size: 17))
                        Spacer()

                        Text("\(product.price)")
                            .font(.custom("Raleway-Bold", size: 20))
                            .foregroundColor(Color.purple)
                    }
                    .padding(.vertical, 20)

                    // Add button
                    Button {

                    } label: {
                        Text("Add to basket")
                            .font(.custom("Raleway-Bold", size: 20))
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.purple
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }


                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG").ignoresSafeArea())

    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())

        MainPage()
    }
}
