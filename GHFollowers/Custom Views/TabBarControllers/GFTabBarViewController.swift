//
//  GFTabBarViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/8/24.
//

import UIKit

class GFTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavouritesListNavigationController()]
    }

    func createSearchNavigationController() -> UINavigationController {
        let searchNavigationController = UINavigationController(rootViewController: SearchViewController())
        searchNavigationController.title = "Search"
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return searchNavigationController
    }

    func createFavouritesListNavigationController() -> UINavigationController {
        let favouritesListNavigationController =
            UINavigationController(rootViewController: FavouritesListViewController())
        favouritesListNavigationController.title = "Favourites"
        favouritesListNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        return favouritesListNavigationController
    }
}
