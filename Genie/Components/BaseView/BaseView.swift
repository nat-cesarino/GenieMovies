//
//  BaseView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 05/12/22.
//

import Foundation
import UIKit

open class BaseView: UIView {
    
    // =========================================================
    // MARK: - Public methods
    // =========================================================
    
    public init() {
        super.init(frame: .zero)
        super.backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init(backgroundColor: UIColor = UIColor(hex: "#141414ff")!) {
        super.init(frame: .zero)
        super.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
