//
//  FollowerCollectionViewCell.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/19/24.
//

import SwiftUI
import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    static let reuseID = "FollowerCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower: Follower) {
        contentConfiguration = UIHostingConfiguration { FollowerCollectionView(follower: follower) }
    }
}
