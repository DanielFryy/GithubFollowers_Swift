//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/15/24.
//

import UIKit

class FollowerListViewController: UIViewController {
    enum Section { case main }

    var username: String!
    var followers = [Follower]()
    var page = 1
    var hasMoreFollowers = true

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
        )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            FollowerCollectionViewCell.self,
            forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID
        )
    }

    func getFollowers(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(followers):
                if followers.count < NetworkManager.shared.itemsPerPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Bad Stuff Happend",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, follower in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCollectionViewCell.reuseID,
                    for: indexPath
                ) as! FollowerCollectionViewCell
                cell.set(follower: follower)
                return cell
            }
        )
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let isBottomOfView = offsetY > contentHeight - height
        
        if isBottomOfView {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
