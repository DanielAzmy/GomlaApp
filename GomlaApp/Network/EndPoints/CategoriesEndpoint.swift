//
//  CategoriesEndpoint.swift
//  GomlaApp
//
//  Created by Daniel azmy on 01/06/2026.
//

import Alamofire
import Foundation

enum CategoriesEndpoint: Endpoint{
    case categories(id: String)
    case products(id: String)
    var path: String {
        switch self {
        case .categories(id: let id):
            return "categories/\(id)/details?area=%D8%A7%D9%84%D8%B8%D8%A7%D9%87%D8%B1&city=%D8%A7%D9%84%D9%82%D8%A7%D9%87%D8%B1%D9%87"
        case .products(id: let id):
            return "categories/\(id)/products?area=%D8%A7%D9%84%D8%B8%D8%A7%D9%87%D8%B1&city=%D8%A7%D9%84%D9%82%D8%A7%D9%87%D8%B1%D9%87&page_number=1&page_size=20"
        }
    }
    var parameters: Parameters? {return nil}
    var method: Alamofire.HTTPMethod { return.get }
}
