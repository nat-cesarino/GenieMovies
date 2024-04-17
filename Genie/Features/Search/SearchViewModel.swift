//
//  SearchViewModel.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 01/02/23.
//

import Foundation

class SearchViewModel {
    
    // =========================================================
    // MARK: - Public properties
    // =========================================================
    
    var titles: [Title] = []
    var title: Title?
    
    // =========================================================
    // MARK: - Init
    // =========================================================
    
    init() {}
    
    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    func searchTitles(query: String, completion: @escaping ([Title]) -> Void) {
        APICaller.shared.search(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    self.titles = titles
                    completion(self.titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    // apagar
    func fetchTitles(completion: @escaping ([Title]) -> Void) {
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(self.titles)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTitle(row: Int) -> Title? {
        return titles[row]
    }
}
