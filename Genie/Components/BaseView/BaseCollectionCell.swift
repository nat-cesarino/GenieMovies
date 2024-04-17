//
//  BaseCollectionCell.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 04/02/23.
//

import Foundation
import UIKit

open class BaseCollectionCell: UICollectionViewCell {

    // =========================================================
    // MARK: - Static properties
    // =========================================================
    
    static let reuseIdentifier = "identifier"
    
    // =========================================================
    // MARK: - Init
    // =========================================================

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) { return nil }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }
}
