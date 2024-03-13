//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/11/24.
//

import UIKit

extension UIView {
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }

    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }

    func centerX(in superView: UIView) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(centerXAnchor.constraint(equalTo: superView.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    func centerY(in superView: UIView) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(centerYAnchor.constraint(equalTo: superView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    func center(in superView: UIView) {
        centerX(in: superView)
        centerY(in: superView)
    }
}
