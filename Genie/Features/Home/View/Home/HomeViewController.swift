//
//  HomeViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 23/11/22.
//

import SnapKit
import UIKit
import RxSwift

class HomeViewController: BaseViewController, SetupView {
    
    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private let viewModel = HomeViewModel()
    private lazy var baseView = HomeView()
    private let disposeBag = DisposeBag()
    var dataController: DataController {
        return (UIApplication.shared.delegate as! AppDelegate).dataController
    }
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================

    init() {
        super.init(backgroundColor: UIColor(hex: "#141414ff")!)
        setup()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchTrendingMovies()
        baseView.collectionView.reloadData()
    }

    // =========================================================
    // MARK: - Private Methods
    // =========================================================
    private func setup(){
        setupUI()
        setupCollectionView()
        bind()
    }
    
    private func bind() {
        viewModel.dataState.skip(1).subscribe(onNext: { [weak self] state in
            guard let `self` = self else { return }
            switch state {
            case .loading:
                self.showLoading()
                
            case .success, .error:
                self.stopLoading()
                self.baseView.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
    }
    
    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    public func buildViewHierarchy() {
        view.addSubview(baseView)
    }
    
    public func setupConstraints() {
        baseView.snp.makeConstraints {
            $0.top.equalTo(topSafeArea)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// =========================================================
// MARK: - Collection View Delegate and Data Source
// =========================================================

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let posterTitle = viewModel.titles[indexPath.item].posterPath else { return UICollectionViewCell()}
        cell.configure(with: posterTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let title = viewModel.fetchTitle(row: indexPath.row) else { return }
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderView", for: indexPath) as! HomeHeaderView
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
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
