//
//  TransparentButton.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 12/02/23.
//

import Foundation
import UIKit
import SnapKit

class TransparentButton: UIButton, SetupView {
    
    // =========================================================
    // MARK: - UI properties
    // =========================================================
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    // =========================================================
    // MARK: - Initializer
    // =========================================================

    public init(icon: UIImage?) {
        self.iconImageView.image = icon
        super.init(frame: .zero)
        buildSelf()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    // =========================================================
    // MARK: - SetupView methods
    // =========================================================
    
    private func buildSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        alpha = 0.5
    }
    
    func buildViewHierarchy() {
        addSubview(iconImageView)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
