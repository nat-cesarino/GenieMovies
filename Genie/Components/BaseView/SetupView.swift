//
//  SetupView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 05/12/22.
//

import Foundation

public protocol SetupView {
    func buildViewHierarchy()
    func setupConstraints()
}

extension SetupView {
    public func setupUI() {
        buildViewHierarchy()
        setupConstraints()
    }
}
