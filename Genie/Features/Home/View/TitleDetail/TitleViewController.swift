//
//  TitleViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 12/12/22.
//

import UIKit
import SnapKit
import Foundation
import RxSwift
import CoreData

class TitleViewController: BaseViewController, SetupView {

    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private lazy var viewModel = TitleViewModel(title: titleModel)
    private var baseView = TitleView()
    private var titleModel: TitleDetailsModel
    private let disposeBag = DisposeBag()
    var dataController: DataController {
        return (UIApplication.shared.delegate as! AppDelegate).dataController
    }
    var favoriteTitle: FavoriteTitle?
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================
    
    init(titleModel: TitleDetailsModel) {
        self.titleModel = titleModel
        super.init(backgroundColor: UIColor(hex: "#141414ff")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // =========================================================
    // MARK: - Private methods
    // =========================================================

    private func setup(){
        setupUI()
        bind()
    }
    
    private func bind() {
        // Update UI
        baseView.setImage(with: titleModel.posterPath ?? "")
        baseView.ratingLabel.text = titleModel.rating
        baseView.titleLabel.text = titleModel.titleName
        baseView.overviewLabel.text = titleModel.overview

        // Update actions
        baseView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        baseView.favoriteMarkedButton.addTarget(self, action: #selector(markFavorite), for: .touchUpInside)
        baseView.favoriteUnmarkedButton.addTarget(self, action: #selector(markFavorite), for: .touchUpInside)
        baseView.toggleButton(isFavorite: isFavorite())
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    func fetchFavoriteMovieFromDatabase() -> FavoriteTitle? {
        let movieId = viewModel.title.id ?? 0
        let fetchRequest: NSFetchRequest<FavoriteTitle> = FavoriteTitle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        let results = try? dataController.viewContext.fetch(fetchRequest)
        self.favoriteTitle = results?.first ?? FavoriteTitle(context: dataController.viewContext)
        return favoriteTitle
    }

    func isFavorite() -> Bool {
        let movieId = viewModel.title.id ?? 0
        let fetchRequest: NSFetchRequest<FavoriteTitle> = FavoriteTitle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        let results = try? dataController.viewContext.fetch(fetchRequest)
        self.favoriteTitle = results?.first ?? FavoriteTitle(context: dataController.viewContext)
        return results?.first != nil
    }

    @objc func markFavorite() {
        let movieId = viewModel.title.id ?? 0
        let context = dataController.viewContext

        guard let favorite = fetchFavoriteMovieFromDatabase() else { return }

        if isFavorite() {
            context.delete(favorite)
            try? context.save()
            self.baseView.toggleButton(isFavorite: false)
        } else {
            let newFavorite = FavoriteTitle(context: context)
            newFavorite.id = Int64(movieId)
            newFavorite.titleName = viewModel.title.titleName
            newFavorite.overview = viewModel.title.overview
            newFavorite.posterPath = viewModel.title.posterPath
            newFavorite.rating = viewModel.title.rating

            try? context.save()
            self.baseView.toggleButton(isFavorite: true)
        }
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
