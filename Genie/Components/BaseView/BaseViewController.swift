//
//  BaseViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 18/02/23.
//

import UIKit
import Lottie
import SnapKit

open class BaseViewController: UIViewController {
    
    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private var loadingView: LoadingView?

    // =========================================================
    // MARK: - Public properties
    // =========================================================
    
    public var safeWindow: UIWindow {
        return view.window ?? UIWindow(frame: view.frame)
    }
    
    // =========================================================
    // MARK: - Init
    // =========================================================
    
    public init(basicBackgroundColor: UIColor = .black) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = basicBackgroundColor
    }
    
    public init(backgroundColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = backgroundColor
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
    
    // =========================================================
    // MARK: - Lifecycle
    // =========================================================
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestures()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // =========================================================
    // MARK: - Private methods
    // =========================================================
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDisappear))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDisappear() {
        view.endEditing(true)
    }

    // =========================================================
    // MARK: - Loading
    // =========================================================

    public func showLoading() {
        if loadingView != nil {
            stopLoading()
        }

        let loadingView = LoadingView()
        self.view.addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.top.leading.trailing.bottom.equalToSuperview() }
        loadingView.animationView.play()
        self.loadingView = loadingView
    }

    public func stopLoading() {
        if let loadingView = loadingView {
            loadingView.animationView.pause()
            loadingView.removeFromSuperview()
        }

        loadingView = nil
    }
}
