//
//  UIControl+RX.swift
//  Genie
//
//  Created by Nathalie Cesarino on 11/04/23.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: UIControl {
    var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
