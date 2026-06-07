//
//  BannerModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct BannerModel: Codable, Sendable {
    let id: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
    }
}
