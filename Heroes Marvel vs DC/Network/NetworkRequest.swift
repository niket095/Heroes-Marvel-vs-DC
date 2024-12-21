//
//  NetworkDataFetch.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 14.12.2024.
//

import Foundation
import UIKit

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
    
//    func fetchHTTPCatImage(statusCode: Int, completion: @escaping (Int, UIImage?) -> Void) {
//        let urlString = "https://http.cat/\(statusCode).jpg"
//        guard let url = URL(string: urlString) else {
//            print("Ошибка кода статуса: \(statusCode)")
//            completion(statusCode, nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
//
//            if let error = error {
//                print("Ошибка кода статуса: \(statusCode) : \(error.localizedDescription)")
//                completion(statusCode, nil)
//                return
//            }
//
//            guard let data = data, let image = UIImage(data: data) else {
//                completion(statusCode, nil)
//                return }
//            completion(statusCode, image)
//        }
//    task.resume()
//}
//
//    func fetchHTTPDogImage(statusCode: Int, completion: @escaping (Int, UIImage?) -> Void) {
//        let urlString = "https://http.dog/\(statusCode).jpg"
//        guard let url = URL(string: urlString) else {
//            print("Ошибка кода статуса: \(statusCode)")
//            completion(statusCode, nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
//
//            if let error = error {
//                print("Ошибка кода статуса: \(statusCode) : \(error.localizedDescription)")
//                completion(statusCode, nil)
//                return
//            }
//
//            guard let data = data, let image = UIImage(data: data) else {
//                completion(statusCode, nil)
//                return }
//            completion(statusCode, image)
//        }
//    task.resume()
//}
}

