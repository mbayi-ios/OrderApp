//
//  LoginPageModel.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import Foundation

class LoginPageModel: ObservableObject {
    //login properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    //Register Properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false

    func login() {
        // Do Action Here
    }

    func register() {
        // Do Action Here
    }

    func forgotPassword() {
        // Do Action Here
    }
}
