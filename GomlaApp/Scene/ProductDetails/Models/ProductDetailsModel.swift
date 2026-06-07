//
//  ProductDetailsModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//


struct ProductDetailsModel: Codable {
    let id: Int
    let merchantId: String
    let nameEn: String
    let nameAr: String
    let descriptionEn: String
    let descriptionAr: String
    let price: Double
    let discount: Double
    let originalPrice: Double
    let maximumQuantity: Int
    let images: [String]
    let status: Int
    let category: ProductCategory
    let brand: ProductBrand
    let stock: Bool
    let installmentAmount: Double
    let installmentPeriod: Int
    let seller: String
    let productId: String
    let isPromotion: Bool
    let sellingUnit: String
    let sellingUnitCount: Int
    let discountAmount: Double
    let isProductHasCfOffer: Bool
    let showPriceAfterOffer: Bool
    let titleTagEn: String
    let titleTagAr: String
    let metaDescriptionEn: String
    let metaDescriptionAr: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case merchantId         = "merchant_id"
        case nameEn             = "name_en"
        case nameAr             = "name_ar"
        case descriptionEn      = "description_en"
        case descriptionAr      = "description_ar"
        case price
        case discount
        case originalPrice      = "original_price"
        case maximumQuantity    = "maximum_quantity"
        case images
        case status
        case category
        case brand
        case stock
        case installmentAmount  = "installment_amount"
        case installmentPeriod  = "installment_period"
        case seller
        case productId          = "product_id"
        case isPromotion        = "is_promotion"
        case sellingUnit        = "selling_unit"
        case sellingUnitCount   = "selling_unit_count"
        case discountAmount
        case isProductHasCfOffer = "is_product_has_cf_offer"
        case showPriceAfterOffer = "showPriceAfterOffer"
        case titleTagEn         = "title_tag_en"
        case titleTagAr         = "title_tag_ar"
        case metaDescriptionEn  = "meta_description_en"
        case metaDescriptionAr  = "meta_description_ar"
    }
}

struct ProductCategory: Codable {
    let id: String
    let nameAr: String
    let nameEn: String
    let image: String
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case image
        case path
    }
}

struct ProductBrand: Codable {
    let id: String
    let nameAr: String
    let nameEn: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
    }
}