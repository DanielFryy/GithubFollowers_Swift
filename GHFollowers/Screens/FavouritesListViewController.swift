//
//  FavouritesListViewController.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/13/24.
//

import UIKit

class FavouritesListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case let .success(favourites):
                print(favourites)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
