//
//  ItemModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation


// MARK: - Item Model

enum ItemModel: Sendable {
    case banner(BannerModel)
    case category(CategoryModel)
    case product(Product)
}

// MARK: - Hashable

extension ItemModel: nonisolated Hashable {

    nonisolated func hash(into hasher: inout Hasher) {

        switch self {

        case .banner(let model):
            hasher.combine(model.id)

        case .category(let model):
            hasher.combine(model.id)

        case .product(let model):
            hasher.combine(model.id)
        }
    }

    nonisolated static func == (
        lhs: ItemModel,
        rhs: ItemModel
    ) -> Bool {

        switch (lhs, rhs) {

        case (.banner(let a), .banner(let b)):
            return a.id == b.id

        case (.category(let a), .category(let b)):
            return a.id == b.id

        case (.product(let a), .product(let b)):
            return a.id == b.id

        default:
            return false
        }
    }
}
