//
//  HomeViewsSections.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

enum HomeViewsSections: Equatable, Sendable{
    case banner
    case sections(HomeSectionModel)
    case categories
}

extension HomeViewsSections: nonisolated Hashable {

    nonisolated func hash(into hasher: inout Hasher) {
        switch self {

        case .banner:
            hasher.combine("banner")

        case .categories:
            hasher.combine("categories")

        case .sections(let section):
            hasher.combine(section.id)
        }
    }

    nonisolated static func == (
        lhs: HomeViewsSections,
        rhs: HomeViewsSections
    ) -> Bool {

        switch (lhs, rhs) {

        case (.banner, .banner):
            return true

        case (.categories, .categories):
            return true

        case (.sections(let a), .sections(let b)):
            return a.id == b.id

        default:
            return false
        }
    }
}
