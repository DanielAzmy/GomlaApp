//
//  TCategoryEntity.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//


struct CategoryEntity: Decodable {
    var id: String?
    var nameEn: String?
    var nameAr: String?
    var image: String?
    var childrenType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case image
        case childrenType = "children_type"
    }
}


struct CategoryResponse: Decodable{
    var categories: [CategoryEntity]?
}

struct CategoryProductsResponse: Decodable{
    var products: [Product]?
}
