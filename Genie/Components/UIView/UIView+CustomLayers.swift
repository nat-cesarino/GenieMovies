//
//  UIView+CustomLayers.swift
//  Genie
//
//  Created by Nathalie Cesarino on 11/04/23.
//
import Foundation
import UIKit

public extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(
             roundedRect: bounds,
             byRoundingCorners: corners,
             cornerRadii: CGSize(width: radius, height: radius)
         )
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
}

