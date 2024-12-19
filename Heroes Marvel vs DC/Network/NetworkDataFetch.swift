//
//  NetworkImageFetch.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 14.12.2024.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchMarvelHeroes(responce: @escaping (HeroModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(url: API.url) { result in
            switch result {
            case .success(let data):
                do {
                    let heroesElements = try JSONDecoder().decode(HeroModel.self, from: data)
                    responce(heroesElements, nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print("Error receive requesting data:", error.localizedDescription)
                responce(nil, error)
            }
        }
    }

    
       
   
}

