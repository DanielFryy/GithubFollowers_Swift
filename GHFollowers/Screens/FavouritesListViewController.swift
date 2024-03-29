//
//  FavouritesListViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/13/24.
//

import UIKit

class FavouritesListViewController: GFDataLoadingViewController {
    let tableView = UITableView()
    var favourites = [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }

    override func updateContentUnavailableConfiguration(using _: UIContentUnavailableConfigurationState) {
        if favourites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "No favourites"
            config.secondaryText = "Add a favourite on the follower list screen"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }

    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(favourites):
                self.updateUI(with: favourites)
            case let .failure(error):
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }

    func updateUI(with favourites: [Follower]) {
        self.favourites = favourites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}

extension FavouritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: FavouriteTableViewCell.reuseID) as! FavouriteTableViewCell
        let favourite = favourites[indexPath.row]
        cell.set(favourite: favourite)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let destinationViewController = FollowerListViewController(username: favourite.login)

        navigationController?.pushViewController(destinationViewController, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
