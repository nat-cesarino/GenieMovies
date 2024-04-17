//
//  FavoritesViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 23/11/22.
//

import Foundation
import UIKit
import SnapKit
import Lottie
import RxSwift
import CoreData

class FavoritesViewController: BaseViewController, SetupView {
    
    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private let viewModel = FavoritesViewModel()
    private lazy var baseView = FavoritesView()
    private let disposeBag = DisposeBag()

    var dataController: DataController {
        return (UIApplication.shared.delegate as! AppDelegate).dataController
    }

    var fetchedResultsController: NSFetchedResultsController<FavoriteTitle>?
    
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
        setupFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        baseView.tableView.reloadData()
        printPersistedObjects()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }

    // =========================================================
    // MARK: - Private Methods
    // =========================================================

    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<FavoriteTitle> = FavoriteTitle.fetchRequest()
        let predicate = NSPredicate(format: "id != 0")
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "titleName", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: dataController.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }

    private func setup(){
        setupUI()
        setupTableView()
    }
    
    private func setupTableView() {
        self.baseView.tableView.delegate = self
        self.baseView.tableView.dataSource = self
    }

    // Checking the persisted objects from Core Data
    func printPersistedObjects() {
        let fetchRequest: NSFetchRequest<FavoriteTitle> = FavoriteTitle.fetchRequest()

        do {
            let results = try dataController.viewContext.fetch(fetchRequest)
            for favoriteTitle in results {
                print("Favorite Title:")
                print("ID: \(favoriteTitle.id)")
            }
        } catch {
            print("Failed to fetch persisted objects: \(error)")
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

// =========================================================
// MARK: - Table View Delegate and Data Source
// =========================================================

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        let currentSection = sections[section]
        return currentSection.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aFavoriteTitle = fetchedResultsController?.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseIdentifier, for: indexPath) as! FavoritesCell
        
        let posterPath = aFavoriteTitle?.posterPath ?? ""
        let titleName = aFavoriteTitle?.titleName ?? ""
        cell.setupCellWith(path: posterPath, titleName: titleName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let title = fetchedResultsController?.object(at: indexPath) {
            let titleDetailsVC = TitleViewController(
                titleModel:
                    TitleDetailsModel(
                        id: Int(title.id),
                        posterPath: title.posterPath,
                        titleName: title.titleName,
                        overview: title.overview,
                        rating: title.rating
                    )
            )
            navigationController?.pushViewController(titleDetailsVC, animated: true)
        }
    }
}

// =========================================================
// MARK: - NSFetchedResultsControllerDelegate
// =========================================================

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        baseView.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        baseView.tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            baseView.tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            baseView.tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        default:
            break
        }
    }
}
