//
//  SearchResultsViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 04/02/23.
//

import Foundation
import UIKit
import SnapKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func SearchResultsViewControllerDidTapItem(_ viewModel: Title)
}

class SearchResultsViewController: UIViewController {

    public var titles: [Title] = [Title]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
  //      layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: SearchResultsCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor(hex: "#141414ff")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#141414ff")
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}

// =========================================================
// MARK: - Collection View Delegate and Data Source
// =========================================================

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCell.reuseIdentifier, for: indexPath) as? SearchResultsCell else { return UICollectionViewCell() }
        
        let title = titles[indexPath.row]
        cell.setupCellWith(path: title.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        self.delegate?.SearchResultsViewControllerDidTapItem(title)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing = CGFloat(8)
        let numberOfColumns: CGFloat = 3
        let itemWidth = (collectionViewWidth - ((numberOfColumns - 1) * spacing)) / numberOfColumns
        let itemHeight = (itemWidth * CGFloat(1.33))
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
