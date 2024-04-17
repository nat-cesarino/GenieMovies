//
//  SearchView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 01/02/23.
//

import Foundation
import UIKit
import SnapKit

class SearchView: BaseView, SetupView {
    
    // =========================================================
    // MARK: - Properties
    // =========================================================

    let image: UIImageView = {
        let view = UIImageView(image: UIImage(named: "horror_movie"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================
    
    override init() {
        super.init(backgroundColor: UIColor(hex: "#141414ff")!)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    private func setup() {
        setupUI()
    }
    
    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    func buildViewHierarchy() {
        addSubview(image)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.height.equalTo(1200)
                $0.width.equalTo(600)
            } else {
                $0.height.equalTo(600)
                $0.width.equalTo(300)
            }
        }
    }
}
