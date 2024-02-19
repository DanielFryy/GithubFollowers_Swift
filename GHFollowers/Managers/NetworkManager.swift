//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/18/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users"

    private init() {}

    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = "\(baseURL)/\(username)/followers?per_page=100&page=\(page)"
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
}
