//
//  HomeViewModel.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 15/12/22.
//

import Foundation
import RxRelay

class HomeViewModel {

    // =========================================================
    // MARK: - Public properties
    // =========================================================
    
    var titles: [Title] = []
    var title: Title?
    var favoriteMovies: [Title] = []
    
    // =========================================================
    // MARK: - Relays
    // =========================================================
    
    let dataState = BehaviorRelay<DataState<[Title], String>>(value: .loading)
    
    // =========================================================
    // MARK: - Init
    // =========================================================
    
    init() {}
    
    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    // TODO: Move this to a remote data source layer
    func fetchTrendingMovies() {
        dataState.accept(.loading)
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                self.dataState.accept(.success(self.titles))
            case .failure(let error):
                print(error)
                self.dataState.accept(.error(APIError.failedToGetData.localizedDescription))
            }
        }
    }
    
    func fetchTitle(row: Int) -> Title? {
        return titles[row]
    }
}
