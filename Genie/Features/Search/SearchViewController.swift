//
//  SearchViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 01/02/23.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: BaseViewController, SetupView {

    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private let viewModel = SearchViewModel()
    private lazy var baseView = SearchView()
    private var titles: [Title] = [Title]()
    
    private lazy var searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Type your movie mood here"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.tintColor = .white
        return controller
    }()
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================

    init() {
        super.init(backgroundColor: UIColor(hex: "#141414ff")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#141414ff")
        
        setup()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // =========================================================
    // MARK: - Private Methods
    // =========================================================
    
    private func setup(){
        setupUI()
    }

    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    public func buildViewHierarchy() {
        view.addSubview(baseView)
    }
    
    public func setupConstraints() {
        baseView.snp.makeConstraints {
            $0.top.equalTo(view.topSafeArea)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(bottomSafeArea)
        }
    }
}

// =========================================================
// MARK: - Search Results Delegate
// =========================================================

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultsController.delegate = self
        
        viewModel.searchTitles(query: query) { _ in
            resultsController.titles = self.viewModel.titles
            resultsController.searchResultsCollectionView.reloadData()
            
        }
    }
    
    func SearchResultsViewControllerDidTapItem(_ title: Title) {
        let titleDetailsVC = TitleViewController(
            titleModel:
                TitleDetailsModel(
                    id: title.id,
                    posterPath: title.posterPath,
                    titleName: title.title,
                    overview: title.overview,
                    rating: " TMDB " + String(format: "%.1f ", title.voteAverage ?? "0.0")
                )
        )
        navigationController?.pushViewController(titleDetailsVC, animated: true)
    }
}
