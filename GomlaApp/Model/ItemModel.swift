//
//  ItemModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

enum ItemModel: Sendable {
    case banner(BannerModel)
    case specialItem(Product)
    case category(CategoryModel)
    case bestSeller(Product)
}

extension ItemModel: nonisolated Hashable {
    nonisolated func hash(into hasher: inout Hasher) {
        switch self {
        case .banner(let model):        hasher.combine(model.id)
        case .specialItem(let model):   hasher.combine(model.id)
        case .category(let model):      hasher.combine(model.id)
        case .bestSeller(let model):    hasher.combine(model.id)
        }
    }
    
    nonisolated static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        switch (lhs, rhs) {
        case (.banner(let a), .banner(let b)):             return a.id == b.id
        case (.specialItem(let a), .specialItem(let b)):   return a.id == b.id
        case (.category(let a), .category(let b)):         return a.id == b.id
        case (.bestSeller(let a), .bestSeller(let b)):     return a.id == b.id
        default:                                           return false
        }
    }
}

struct BannerModel: Codable, Sendable {
    let id: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
    }
}

struct Product: Codable, Sendable {
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
        case size = "parentCategory"
        case discount
        case sellingUnit = "selling_unit"
    }
}

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

struct BestSellerModel: Sendable {
    let id = UUID()
    let imageUrl: String
    let title: String
    let price: Double
}

struct BaseResponse<T: Decodable>: Decodable {
    var status: Int?
    var message: String?
    var data: T?
}


struct homeDataModel: Codable {
    let banners: [BannerModel]
    let categories: [CategoryModel]
    let sections: [HomeSectionModel]
}

struct ProductContainer: Codable{
    let products: [Product]
}

struct HomeSectionModel: Codable {
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
