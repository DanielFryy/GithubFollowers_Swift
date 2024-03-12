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
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!

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
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: topConstraintConstant
        )
        logoImageViewTopConstraint.isActive = true

        NSLayoutConstraint.activate([
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

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor, center: NSLayoutXAxisAnchor, size: CGSize, padding: UIEdgeInsets = .zero) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(topAnchor.constraint(equalTo: top, constant: padding.top))
        constraints.append(centerXAnchor.constraint(equalTo: center))
        constraints.append(heightAnchor.constraint(equalToConstant: size.height))
        constraints.append(widthAnchor.constraint(equalToConstant: size.width))
        NSLayoutConstraint.activate(constraints)
    }

    func anchor(top: NSLayoutYAxisAnchor, center: NSLayoutXAxisAnchor, size: CGSize, paddingTop: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        constraints.append(centerXAnchor.constraint(equalTo: center))
        constraints.append(heightAnchor.constraint(equalToConstant: size.height))
        constraints.append(widthAnchor.constraint(equalToConstant: size.width))
        NSLayoutConstraint.activate(constraints)
    }

    func anchor(
        top: NSLayoutYAxisAnchor,
        leading: NSLayoutXAxisAnchor,
        trailing: NSLayoutXAxisAnchor,
        height: CGFloat,
        padding: UIEdgeInsets = .zero
    ) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(topAnchor.constraint(equalTo: top, constant: padding.top))
        constraints.append(leadingAnchor.constraint(equalTo: leading, constant: padding.left))
        constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -padding.right))
        constraints.append(heightAnchor.constraint(equalToConstant: height))
        NSLayoutConstraint.activate(constraints)
    }

    func anchor(
        bottom: NSLayoutYAxisAnchor,
        leading: NSLayoutXAxisAnchor,
        trailing: NSLayoutXAxisAnchor,
        height: CGFloat,
        padding: UIEdgeInsets = .zero
    ) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom))
        constraints.append(leadingAnchor.constraint(equalTo: leading, constant: padding.left))
        constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -padding.right))
        constraints.append(heightAnchor.constraint(equalToConstant: height))
        NSLayoutConstraint.activate(constraints)
    }

    func centerX(in view: UIView) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(centerXAnchor.constraint(equalTo: view.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    func centerY(in view: UIView) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(centerYAnchor.constraint(equalTo: view.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    func center(in view: UIView) {
        centerX(in: view)
        centerY(in: view)
    }
}
