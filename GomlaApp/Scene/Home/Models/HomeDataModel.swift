//
//  HomeDataModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct HomeDataModel: Codable {

    let banners: [BannerModel]
    let categories: [CategoryModel]
    let sections: [HomeSectionModel]
}
