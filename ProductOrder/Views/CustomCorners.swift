//
//  CustomCorners.swift
//  ProductOrder
//
//  Created by Amby on 29/09/2022.
//

import Foundation

import SwiftUI
struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
