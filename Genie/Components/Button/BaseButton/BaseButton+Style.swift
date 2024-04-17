//
//  BaseButton+Style.swift
//  Genie
//
//  Created by Nathalie Cesarino on 11/04/23.
//

import Foundation
import UIKit

protocol BaseButtonStyleType {
    func colorForBorder(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor

    func colorForFill(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor

    func colorForTextAndIcon(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor
}

final class SofiaButtonStyle: BaseButtonStyleType {
    func colorForBorder(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor {
        switch state {
        case .normal:
            switch style {
            case .secondary:
                return colorScheme.normal
            default:
                return .clear
            }

        case .touched:
            switch style {
            case .secondary:
                return colorScheme.touched
            default:
                return .clear
            }

        case .disable:
            return .clear
        }
    }

    func colorForFill(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor {
        switch state {
        case .normal:
            switch style {
            case .primary:
                return colorScheme.normal
            default:
                return .clear
            }

        case .touched:
            switch style {
            case .primary:
                return colorScheme.touched
            default:
                return .clear
            }

        case .disable:
            return UIColor(hex: "0xdee2e6ff") ?? .black
        }
    }

    func colorForTextAndIcon(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme,
        state: BaseButton.State
    ) -> UIColor {
        switch state {
        case .normal:
            switch style {
            case .primary:
                return UIColor(hex: "0xffffffff") ?? .black
            default:
                return colorScheme.normal
            }
        case .touched:
            switch style {
            case .primary:
                return UIColor(hex: "0xffffffff") ?? .black
            default:
                return colorScheme.touched
            }
        case .disable:
            return UIColor(hex: "0x868e96ff") ?? .black
        }
    }
}
