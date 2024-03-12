//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
