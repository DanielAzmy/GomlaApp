//
//  Product.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct Product: Codable, Sendable, Hashable {
    let id: String
    let imageUrl: String
    let title: String
    let size: String?
    let price: Double
    let discount: Double
    let sellingUnit: String

    enum CodingKeys: String, CodingKey {

        case id = "product_id"
        case imageUrl = "image"
        case title = "name_en"
        case price
        case discount
        case sellingUnit = "selling_unit"
        case size = "parentCategory"
    }
}

