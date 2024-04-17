//
//  FavoritesView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 12/02/23.
//

import Foundation
import UIKit
import SnapKit

class FavoritesView: BaseView, SetupView {
    
    // =========================================================
    // MARK: - Properties
    // =========================================================
    
    let tableView: UITableView = {
        let view = UITableView()
        view.separatorColor = UIColor(hex: "#141414ff")
        view.backgroundColor = UIColor(hex: "#141414ff")
        view.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseIdentifier)
        return view
    }()
    
    // =========================================================
    // MARK: - Life Cycle
    // =========================================================
    
    override init() {
        super.init(backgroundColor: UIColor(hex: "#141414ff")!)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    private func setup() {
        setupUI()
    }
    
    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

