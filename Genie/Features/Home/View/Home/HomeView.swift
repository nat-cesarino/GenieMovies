//
//  HomeView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 19/01/23.
//

import Foundation
import UIKit
import SnapKit

class HomeView: BaseView, SetupView {
    
    // =========================================================
    // MARK: - Properties
    // =========================================================

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 8, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hex: "#141414ff")
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeaderView")
        return collectionView
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
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
