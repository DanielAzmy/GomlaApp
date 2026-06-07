//
//  HomeSectionModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct HomeSectionModel: Codable, Sendable, Hashable {

    let id: Int
    let nameEn: String
    let nameAr: String
    let items: ProductContainer
    let type: String

    enum CodingKeys: String, CodingKey {

        case id
        case items
        case type
        case nameEn = "name_en"
        case nameAr = "name_ar"
    }
}
