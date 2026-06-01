//
//  TSubCategoryViewModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//


class SubCategoryViewModel {
    var categoryName: String?
    var isSelected = false
    var subCategoryId: String?
    
    init(entity: CategoryEntity) {
        categoryName = entity.nameEn
        subCategoryId = entity.id
    }
    
//    init(entity: CategoriesOfProduct) {
//        categoryName = entity.name
//        subCategoryId = entity.id
//    }
}
