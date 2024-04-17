//
//  TitleViewModel.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 12/12/22.
//

import Foundation
import RxRelay

class TitleViewModel {
    
    // =========================================================
    // MARK: - Public properties
    // =========================================================
    
    var title: TitleDetailsModel
    
    // =========================================================
    // MARK: - Init
    // =========================================================
    
    init(title: TitleDetailsModel) {
        self.title = title
    }
}
