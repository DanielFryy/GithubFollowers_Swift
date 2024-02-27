//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/26/24.
//

import UIKit

class UserInfoViewController: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissViewController)
        )
        navigationItem.rightBarButtonItem = doneButton
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(user):
                print(user.login)
            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong ",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
