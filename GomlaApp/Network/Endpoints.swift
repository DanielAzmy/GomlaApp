//
//  Endpoints.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {
    var baseURL: String { Constants.baseUrl }
    var headers: HTTPHeaders? { Constants.baseicHeaders }
    var encoding: ParameterEncoding { URLEncoding.default }
    var url: String { baseURL + path }
}
