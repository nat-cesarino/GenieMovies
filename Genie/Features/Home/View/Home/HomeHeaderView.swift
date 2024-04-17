//
//  HomeHeaderView.swift
//  Genie
//
//  Created by Nathalie Cesarino on 18/05/23.
//

import Foundation
import UIKit
import SnapKit

// =========================================================
// MARK: - Subviews
// =========================================================

final class HomeHeaderView: UICollectionReusableView {

    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.numberOfLines = 0
        view.text = "Today's Top Trending Movies"
        view.textAlignment = .center
        return view
    }()

    // =========================================================
    // MARK: - Life Cycle
    // =========================================================

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // =========================================================
    // MARK: - Setup Views
    // =========================================================

extension HomeHeaderView: SetupView {

    public func buildViewHierarchy() {
        addSubview(titleLabel)
    }

    public func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
