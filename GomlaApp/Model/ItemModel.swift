//
//  ItemModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

enum ItemModel: Sendable {
    case banner(BannerModel)
    case specialItem(SpecialItemModel)
    case category(CategoryModel)
    case bestSeller(SpecialItemModel)
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

struct BannerModel: Sendable {
    let id = UUID()
    let imageUrl: String
}

struct SpecialItemModel: Sendable {
    let id = UUID()
    let imageUrl: String
    let title: String
    let size: String?
    let price: Double
    let discount: Double
    let sellingUnit: String
}

struct CategoryModel: Sendable {
    let id = UUID()
    let imageUrl: String
    let name: String
}

struct BestSellerModel: Sendable {
    let id = UUID()
    let imageUrl: String
    let title: String
    let price: Double
}
