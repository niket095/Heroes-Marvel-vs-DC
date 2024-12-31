//
//  NetworkDataFetch.swift
//  PetsDelegate
//
//  Created by Nikita Putilov on 14.12.2024.
//

import Foundation
import UIKit

class NetworkRequest {
    static let shared = NetworkRequest()
    private init() {}
    
    func fetchHTTPAnimalsImage(animal: String, statusCode: Int, completion: @escaping (Int, UIImage?) -> Void) {
        let urlString = "https://http.\(animal)/\(statusCode).jpg"
        guard let url = URL(string: urlString) else {
            print("Ошибка кода статуса: \(statusCode)")
            completion(statusCode, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                print("Ошибка кода статуса: \(statusCode) : \(error.localizedDescription)")
                completion(statusCode, nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(statusCode, nil)
                return }
            completion(statusCode, image)
        }
        task.resume()
    }
}
