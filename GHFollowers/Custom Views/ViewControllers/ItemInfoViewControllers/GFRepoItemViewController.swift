//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/2/24.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    weak var delegate: GFRepoItemViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "Gighub Profile", systemImageName: "person")
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
