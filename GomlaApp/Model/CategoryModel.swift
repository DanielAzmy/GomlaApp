//
//  CategoryModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct CategoryModel: Codable, Sendable {

    let id: String
    let imageUrl: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
        case name = "name_en"
    }
}
