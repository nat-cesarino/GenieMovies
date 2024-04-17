//
//  BaseButton+Nested.swift
//  Genie
//
//  Created by Nathalie Cesarino on 11/04/23.
//

import UIKit

public extension BaseButton {
    struct StyleColorScheme {
        public let normal: UIColor
        public let touched: UIColor
        public let text: UIColor

        public init(normal: UIColor, touched: UIColor, text: UIColor) {
            self.normal = normal
            self.touched = touched
            self.text = text
        }

        public static let `default`: StyleColorScheme = {
            return .init(
                normal: UIColor(hex: "0x004eccff") ?? .white,
                touched: UIColor(hex: "0x001f50ff") ?? .white,
                text: UIColor(hex: "0xffffffff") ?? .white
            )
        }()

        public static let black: StyleColorScheme = {
            return .init(
                normal: UIColor(hex: "0x495057ff") ?? .white,
                touched: UIColor(hex: "0x212529ff") ?? .white,
                text: UIColor(hex: "0xffffffff") ?? .white
            )
        }()

        public static let destructive: StyleColorScheme = {
            return .init(
                normal: UIColor(hex: "0xbc3206ff") ?? .white,
                touched: UIColor(hex: "0x8d2504ff") ?? .white,
                text: UIColor(hex: "0xffffffff") ?? .white
            )
        }()
    }

    enum State {
        case normal
        case touched
        case disable
    }

    enum Style {
        case primary
        case secondary
        case ghost
    }

    enum Icon {
        case left(image: UIImage)
        case right(image: UIImage)
        case none
    }
}

