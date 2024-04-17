//
//  BaseTableCell.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 02/02/23.
//

import UIKit

open class BaseTableCell: UITableViewCell {

    // =========================================================
    // MARK: - Static properties
    // =========================================================
    
    static let reuseIdentifier = "identifier"
    
    // =========================================================
    // MARK: - Init
    // =========================================================
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder: NSCoder) {
        return nil
    }
}
