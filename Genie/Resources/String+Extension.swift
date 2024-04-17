//
//  String+Extension.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 09/12/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
