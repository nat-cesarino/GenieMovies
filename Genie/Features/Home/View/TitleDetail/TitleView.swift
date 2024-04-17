//
//  TitleView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 23/01/23.
//

import Foundation
import UIKit
import SnapKit

class TitleView: BaseView, SetupView {
    
    // =========================================================
    // MARK: - Properties
    // =========================================================
    
    private lazy var scrollableView: ScrollableView = {
        return ScrollableView(containerView: containerView)
    }()

    private let containerView: BaseView = {
        return BaseView(backgroundColor: UIColor(hex: "#141414ff")!)
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let favoriteMarkedButton: TransparentButton = {
        let view = TransparentButton(icon: UIImage(systemName: "heart.fill"))
        view.isHidden = true
        return view
    }()
    
    let favoriteUnmarkedButton: TransparentButton = {
        let view = TransparentButton(icon: UIImage(systemName: "heart"))
        view.isHidden = true
        return view
    }()
    
    let backButton: TransparentButton = {
        let view = TransparentButton(icon: UIImage(systemName: "arrowshape.turn.up.left"))
        return view
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ratingContainerView: BaseView = {
        let view = BaseView(backgroundColor: UIColor(hex: "#f5cb42ff")!)
        return view
    }()
    
    let ratingLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    
    let overviewLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        view.numberOfLines = 0
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
    
    override func draw(_ rect: CGRect) {
        addCornerRadius()
        addGradientLayer()
    }

    // =========================================================
    // MARK: - Methods
    // =========================================================
    
    private func setup() {
        setupUI()
    }
    
    func setImage(with posterPath: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    private func addCornerRadius() {
        ratingContainerView.layer.cornerRadius = ratingContainerView.frame.size.height / 2
        ratingContainerView.clipsToBounds = true
    }
    
    private func addGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor(hex: "#141414ff")?.cgColor]
        gradient.locations = [0.0, 0.8]
        gradientView.layer.addSublayer(gradient)
    }
    
    func toggleButton(isFavorite: Bool) {
        favoriteMarkedButton.isHidden = !isFavorite
        favoriteUnmarkedButton.isHidden = isFavorite
    }
    
    // =========================================================
    // MARK: - Setup Views
    // =========================================================
    
    func buildViewHierarchy() {
        addSubview(scrollableView)
        containerView.addSubview(imageView)
        containerView.addSubview(favoriteMarkedButton)
        containerView.addSubview(favoriteUnmarkedButton)
        containerView.addSubview(backButton)
        containerView.addSubview(gradientView)
        containerView.addSubview(ratingContainerView)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        scrollableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.height.equalTo(1000)
            } else {
                $0.height.equalTo(550)
            }
        }
        
        favoriteMarkedButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(48)
        }
        
        favoriteUnmarkedButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(48)
        }
        
        gradientView.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        ratingContainerView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(ratingLabel.snp.height).multipliedBy(1.8)
            $0.width.equalTo(ratingLabel.snp.width).multipliedBy(1.2)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingContainerView.snp.centerY)
            $0.centerX.equalTo(ratingContainerView.snp.centerX)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(ratingContainerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
