//
//  NetworkManager.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.coincap.io/v2/assets"
    private let limit = 10
    
    private init() {}
    
    func getCoins(offset: Int, completed: @escaping (Result<[CoinInfo], ILError>) -> Void) {
        let endpoint = baseURL + "?limit=\(limit)&offset=\(offset)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let coinData = try decoder.decode(CoinData.self, from: data)
                let coins = coinData.data
                completed(.success(coins))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
