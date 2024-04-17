//
//  ScrollableView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 25/01/23.
//

import UIKit

public final class ScrollableView: BaseView {
    
    // =========================================================
    // MARK: - Subviews
    // =========================================================

    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView: UIView
    
    // =========================================================
    // MARK: - Initializer
    // =========================================================
    
    public init(containerView: UIView) {
        self.containerView = containerView
        super.init()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func updateHeightView(height: CGFloat) {
        containerView.snp.remakeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.height.greaterThanOrEqualTo(height)
        }
    }
}

// =========================================================
// MARK: - Setup Views
// =========================================================

extension ScrollableView: SetupView {

    public func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    public func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
    }
}

