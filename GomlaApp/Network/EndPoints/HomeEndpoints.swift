//
//  HomeEndpoints.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//

import Alamofire

enum HomeEndpoints: Endpoint{
    case home(city: String, area: String)
    case details(id: String)
    var path: String {
        switch self {
        case .home(let city, let area):
            return "talabeyah/home?area=\(area)&city=\(city)"
        case .details(id: let id):
            return "product/\(id)?area=%D8%A7%D9%84%D8%B8%D8%A7%D9%87%D8%B1&city=%D8%A7%D9%84%D9%82%D8%A7%D9%87%D8%B1%D9%87&seller=Talabeyah"
        }
    }
    var parameters: Parameters? {return nil}
    var method: Alamofire.HTTPMethod { return.get }
}



