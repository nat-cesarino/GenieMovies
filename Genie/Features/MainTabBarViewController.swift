//
//  MainTabBarViewController.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 23/11/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // =========================================================
    // MARK: - Private properties
    // =========================================================
    
    private let homeViewController = HomeViewController()
    private let favoritesViewController = FavoritesViewController()
    private let searchViewController = SearchViewController()
    
    // =========================================================
    // MARK: - Lifecycle
    // =========================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // =========================================================
    // MARK: - Private methods
    // =========================================================
    
    private func setupTabBar() {
        setupTabBarImage()
        setupTabBarTitle()
        tabBar.tintColor = .white
        tabBar.backgroundColor = UIColor(hex: "#141414ff")

        let homeNavController = UINavigationController(rootViewController: homeViewController)
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        let searchNavController = UINavigationController(rootViewController: searchViewController)

        let controllers = [homeNavController, favoritesNavController, searchNavController]
        self.viewControllers = controllers
    }

    private func setupTabBarImage() {
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart")
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
    
    private func setupTabBarTitle() {
        homeViewController.title = "Discover. Save. Watch. Repeat."
        homeViewController.tabBarItem.title = "Home"
        favoritesViewController.title = "My Movie Night Picks"
        favoritesViewController.tabBarItem.title = "Favorites"
        searchViewController.title = "Let's Find Your Movie Thrill"
        searchViewController.tabBarItem.title = "Search"
    }
}

