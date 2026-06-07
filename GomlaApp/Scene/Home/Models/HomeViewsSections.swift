//
//  HomeViewsSections.swift
//  GomlaApp
//
//  Created by Daniel azmy on 10/05/2026.
//

import Foundation

/// why Equatable ??
/// to make this model able to be compared
///
/// why Sendable ??
/// to make this modal able to send between threads safely

enum HomeViewsSections: Equatable, Sendable{
    case banner
    case sections(HomeSectionModel)
    case categories
}

/// here we use custom hashing because of diffable data source, that will detrmine
/// - custom identity rules
/// - stable diffable behavior
/// - equality based only on IDs
///
/// why nonisolated ??
/// nonisolated mean that this function is safe to call from any thread because diffable may compute hashes off main thread
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
            /// always true
            return true
            
        case (.categories, .categories):
            /// always true
            return true
             
        case (.sections(let a), .sections(let b)):
            return a.id == b.id
        /// Example:
            /// .sections(id: 2200, title: "Top Picks")
            /// .sections(id: 2200, title: "New Title")
            /// they ara equal because identity is the same

        default:
            return false
        }
    }
}
