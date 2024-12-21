//
//  DCModel.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 17.12.2024.
//

import Foundation

struct DCModel: Codable {
    let id: Int
    let name: String
    let image: Image
}

struct Image: Codable {
    let url: String
}
