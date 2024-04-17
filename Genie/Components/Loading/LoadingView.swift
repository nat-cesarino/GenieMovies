//
//  LoadingView.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 18/02/23.
//

import Foundation
import UIKit
import Lottie
import SnapKit

final class LoadingView: BaseView, SetupView {
    let animationView: LottieAnimationView

    // =========================================================
    // MARK: - Initializer
    // =========================================================

    override init() {
        animationView = LoadingView.buildLoadingView()

        super.init()

        setupUI()
        setupSelf()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // =========================================================
    // MARK: - Private methods
    // =========================================================

    private func setupSelf() {
        backgroundColor = UIColor(hex: "#141414ff")
    }

    // =========================================================
    // MARK: - SetupView
    // =========================================================

    func buildViewHierarchy() {
        addSubview(animationView)
    }

    func setupConstraints() {
        animationView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.leading.greaterThanOrEqualToSuperview().inset(48)
            $0.trailing.bottom.lessThanOrEqualToSuperview().inset(48)
        }
    }

    // =========================================================
    // MARK: - Build methods
    // =========================================================

    private static func buildLoadingView() -> LottieAnimationView {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named("lottie-loading", bundle: Bundle(for: LoadingView.self))
        view.loopMode = .loop
        view.contentMode = .scaleAspectFit
        return view
    }
}
