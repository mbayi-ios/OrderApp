//
//  SearchView.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID

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
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                // search bar

                HStack(spacing: 15) {
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
