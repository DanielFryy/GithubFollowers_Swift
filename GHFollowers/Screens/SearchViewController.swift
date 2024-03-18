//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/13/24.
//

import UIKit

class SearchViewController: UIViewController {
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")

    var isUsernameEmpty: Bool { usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureUsernameTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc func pushFollowerListViewController() {
        guard !isUsernameEmpty else {
            presentGFAlertOnMainThread(
                title: "Empty Username",
                message: "Please enter a username. We need to know who to look for 😀.",
                buttonTitle: "Ok"
            )
            return
        }

        usernameTextField.resignFirstResponder()

        let followerListViewController = FollowerListViewController(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListViewController, animated: true)
    }

    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: topConstraintConstant
            ),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func configureUsernameTextField() {
        usernameTextField.delegate = self

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        pushFollowerListViewController()
        return true
    }
}
