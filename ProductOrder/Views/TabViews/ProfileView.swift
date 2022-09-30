//
//  ProfileView.swift
//  ProductOrder
//
//  Created by Amby on 30/09/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("My Profile")
                        .font(.custom("Raleway-Bold", size: 28))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

                    VStack(spacing: 15) {
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)

                        Text("Amby Mbayi")
                            .font(.custom("Raleway-Regular", size: 16))
                            .fontWeight(.semibold)

                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))

                            Text("Address: 100 Nairobi\nRongai\nRideau Apartment")
                                .font(.custom("Raleway-Regular", size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)


                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)

                    //custom Navigation Links
                    CustomNavigationLink(title: "Edit Profile"){
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }

                    CustomNavigationLink(title: "Shopping Address"){
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }

                    CustomNavigationLink(title: "Order History"){
                        Text("")
                            .navigationTitle("Order History")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }

                    CustomNavigationLink(title: "Cards"){
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }

                    CustomNavigationLink(title: "Notifications"){
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }

                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea())
        }
    }

    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping() -> Detail) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text(title)
                    .font(.custom("Raleway-Regular", size: 17))
                    .fontWeight(.semibold)
                Spacer()

                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
