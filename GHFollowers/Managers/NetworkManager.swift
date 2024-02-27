//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/18/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users"
    let cache = NSCache<NSString, UIImage>()
    let itemsPerPage = 100

    private init() {}

    func getFollowers(
        for username: String,
        page: Int,
        completionHandler: @escaping (Result<[Follower], GFError>) -> Void
    ) {
        let endpoint = "\(baseURL)/\(username)/followers?per_page=\(itemsPerPage)&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUserInfo(for username: String, completionHandler: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = "\(baseURL)/\(username)"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
