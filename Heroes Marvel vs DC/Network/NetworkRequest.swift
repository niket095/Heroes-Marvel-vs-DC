//
//  NetworkDataFetch.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 14.12.2024.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
