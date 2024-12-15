//
//  HeroViewModel.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 14.12.2024.
//

import Foundation

// MARK: - HeroModelElement
struct HeroModelElement: Codable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    var url: URL? {
        return URL(string: path + "." + thumbnailExtension)
    }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// Создаем псевдоним для массива с героями. Говорим HeroModel, а подразумеваем массив героев [HeroModelElement]
typealias HeroModel = [HeroModelElement]
