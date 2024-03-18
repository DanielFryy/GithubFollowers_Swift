//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/2/24.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    weak var delegate: GFFollowerItemViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
