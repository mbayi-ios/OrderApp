//
//  MainPage.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home

    @StateObject var sharedData: SharedDataModel = SharedDataModel()

     @Namespace var animation

    // hide tabbar
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)

                Text("Liked")
                    .tag(Tab.Liked )

                Text("Cart")
                    .tag(Tab.Cart)

                ProfileView()
                    .tag(Tab.Profile)

            }

            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self){ tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color.purple
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1: 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.purple : Color.black.opacity(0.3))
                    }

                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
            ZStack {
                if let product = sharedData.detailProduct, sharedData
                    .showDetailProduct {
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)

                    //adding transitions...
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Tab Cases
//make tab iterable

enum Tab: String, CaseIterable {
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
