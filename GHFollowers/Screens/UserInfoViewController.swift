//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/26/24.
//

import UIKit

class UserInfoViewController: UIViewController {
    let headerView = UIView()
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
        
        layoutUI()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong ",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }

    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
