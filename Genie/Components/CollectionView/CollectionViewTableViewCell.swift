//
//  CollectionViewTableViewCell.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 06/12/22.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    static let identifier = "CollectionViewTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    var titles: [Title] = [Title]()
    
    // =========================================================
    // MARK: - Initializer
    // =========================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    func configure(with titles: [Title]) {
        self.titles = titles
    }
}

// =========================================================
// MARK: - Collection View Delegate and Data Source
// =========================================================

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].posterPath else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
}
