//
//  SearchResultCell.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 02/02/23.
//

import UIKit
import SnapKit

final class SearchCell: BaseTableCell {
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // =========================================================
    // MARK: - Initializer
    // =========================================================
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
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
    
    public func setupCellWith(path: String, titleName: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else {
            return
        }
        titlePosterImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = titleName
    }
}

// =========================================================
// MARK: - Setup Views
// =========================================================

extension SearchCell: SetupView {
    
    public func buildViewHierarchy() {
        addSubview(titlePosterImage)
        addSubview(titleLabel)
    }
    
    public func setupConstraints() {
        titlePosterImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titlePosterImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
