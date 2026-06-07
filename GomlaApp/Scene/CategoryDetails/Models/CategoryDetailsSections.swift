//
//  CategoryDetailsSections.swift
//  GomlaApp
//
//  Created by Daniel azmy on 03/06/2026.
//

import Foundation

enum CategoryDetailsSections: Equatable, Sendable{
    case banner
    case products
}

extension CategoryDetailsSections: nonisolated Hashable {

    nonisolated func hash(into hasher: inout Hasher) {
        switch self {

        case .banner:
            hasher.combine("banner")

        case .products:
            hasher.combine("products")
        }
    }

    nonisolated static func == (
        lhs: CategoryDetailsSections,
        rhs: CategoryDetailsSections
    ) -> Bool {

        switch (lhs, rhs) {

        case (.banner, .banner):
            return true

        case (.products, .products):
            return true

        default:
            return false
        }
    }
}
