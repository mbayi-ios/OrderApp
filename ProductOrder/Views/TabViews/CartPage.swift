//
//  LikedPage.swift
//  ProductOrder
//
//  Created by Amby on 30/09/2022.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Basket")
                                .font(.custom("Raleway-Bold", size: 28))
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image("Delete")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                            
                        }
                        
                        // checking if liked products are empty
                        if sharedData.cartProducts.isEmpty {
                            Group {
                                Image("NoBasket")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .padding()
                                    .padding(.top, 35)
                                
                                Text("No Item added")
                                    .font(.custom("Raleway-Regular", size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("Hit the plus button to save into basket")
                                    .font(.custom("Raleway-Regular", size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            // displaying products
                            VStack(spacing: 15) {
                                ForEach($sharedData.cartProducts) { $product in
                                    HStack(spacing: 0) {
                                        if showDeleteOption {
                                            Button {
                                                deleteProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)
                                            
                                        }
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                // showing total and checkout button
                if !sharedData.cartProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Total")
                                .font(.custom("Raleway-Bold", size: 18))
                                .fontWeight(.semibold)
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom("Raleway-SemiBold", size: 18 ))
                                .foregroundColor(Color.purple)
                        }
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .font(.custom("Raleway-Regular", size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }

                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }

    
    func deleteProduct(product: Product) {
        if let index = sharedData.cartProducts.firstIndex(where: {
            currentProduct in
            return product.id == currentProduct.id
            
        }) {
            
            let _ = withAnimation {
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CardView: View {
    // making product as binding so as to upate in real time
    @Binding var product: Product
    var body: some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 8){
                Text(product.title)
                    .font(.custom("Raleway-Regular", size: 18))
                    .lineLimit(1)

                Text(product.subtitle)
                    .font(.custom("Raleway-Regular", size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.purple)

                //Quantity Button
                HStack(spacing: 10) {
                    Text("Quantity")
                        .font(.custom("Raleway-Regular", size: 14))
                        .foregroundColor(.gray)
                        

                    Button  {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.purple)
                            .cornerRadius(4)

                    }

                    Text("\(product.quantity)")
                        .font(.custom("Raleway-Regular", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Button  {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.purple)
                            .cornerRadius(4)

                    }

                }


            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
            .environmentObject(SharedDataModel())
        
    }
}


