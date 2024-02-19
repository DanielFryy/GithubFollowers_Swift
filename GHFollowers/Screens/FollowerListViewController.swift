//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/15/24.
//

import UIKit

class FollowerListViewController: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(
                    title: "Bad Stuff Happend",
                    message: errorMessage!.rawValue,
                    buttonTitle: "Ok"
                )
                return
            }

            print("Followers count = \(followers.count)")
            print(followers)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
