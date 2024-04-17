//
//  SearchResultsCell.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 04/02/23.
//

import UIKit
import SnapKit

final class SearchResultsCell: BaseCollectionCell {
    
    // =========================================================
    // MARK: - Subviews
    // =========================================================
    
    let titlePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints =  false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // =========================================================
    // MARK: - Initializer
    // =========================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // =========================================================
    // MARK: - Private methods
    // =========================================================
    
    private func setup() {
        setupUI()
    }
    
    // =========================================================
    // MARK: - Public methods
    // =========================================================
    
    public func setupCellWith(path: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else {
            return
        }
        titlePosterImage.sd_setImage(with: url, completed: nil)
    }
}

// =========================================================
// MARK: - Setup Views
// =========================================================

extension SearchResultsCell: SetupView {
    
    public func buildViewHierarchy() {
        addSubview(titlePosterImage)
    }
    
    public func setupConstraints() {
        titlePosterImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

