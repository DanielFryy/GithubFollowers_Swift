//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/5/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    private static let defaults = UserDefaults.standard

    enum Keys {
        static let favourites = "favourites"
    }

    static func updateWith(
        favourite: Follower,
        actionType: PersistenceActionType,
        completionHandler: @escaping (GFError?) -> Void
    ) {
        retrieveFavourites { result in
            switch result {
            case var .success(favourites):
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completionHandler(.alreadyInFavourites)
                        return
                    }
                    favourites.append(favourite)
                case .remove:
                    favourites.removeAll { $0.login == favourite.login }
                }

                completionHandler(save(favourites: favourites))
            case let .failure(error):
                completionHandler(error)
            }
        }
    }

    static func retrieveFavourites(completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completionHandler(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completionHandler(.success(favourites))
        } catch {
            completionHandler(.failure(.invalidData))
        }
    }

    static func save(favourites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.setValue(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
