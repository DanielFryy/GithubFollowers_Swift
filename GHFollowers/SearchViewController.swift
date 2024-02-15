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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUsernameTextField()
        configureCallToActionButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    func configureLogoImageView() {
        view.addSubview(logoImageView)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func configureUsernameTextField() {
        view.addSubview(usernameTextField)

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configureCallToActionButton() {
        view.addSubview(callToActionButton)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
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
