//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/26/24.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews = [UIView]()

    weak var delegate: UserInfoViewControllerDelegate!
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }

    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong ",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }

    func configureUIElements(with user: User) {
        let repoItemViewController = GFRepoItemViewController(user: user)
        repoItemViewController.delegate = self

        let followerItemViewController = GFFollowerItemViewController(user: user)
        followerItemViewController.delegate = self

        add(childViewController: GFUserInfoHeaderViewController(user: user), to: headerView)
        add(childViewController: repoItemViewController, to: itemViewOne)
        add(childViewController: followerItemViewController, to: itemViewTwo)
        dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }

    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
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

extension UserInfoViewController: GFRepoItemViewControllerDelegate, GFFollowerItemViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The URL attached to this user is invalid.",
                buttonTitle: "Ok"
            )
            return
        }

        presentSafariViewController(with: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                title: "No followers",
                message: "This user has no followers. What a shame 😞.",
                buttonTitle: "So sad"
            )
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismissViewController()
    }
}
