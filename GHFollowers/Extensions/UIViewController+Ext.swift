//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/16/24.
//

import SafariServices
import UIKit

fileprivate var containerView: UIView?

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }

    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        guard let containerView = containerView else { return }
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center(in: containerView)

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            guard let containerView1 = containerView else { return }
            containerView1.removeFromSuperview()
            containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
