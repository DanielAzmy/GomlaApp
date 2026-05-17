//
//  BaseResponse.swift
//  GomlaApp
//
//  Created by Daniel azmy on 17/05/2026.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {

    let status: Int?
    let message: String?
    let data: T?
}
