//
//  TSubCategoryViewModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 24/05/2026.
//


struct SubCategoryViewModel {
    var categoryName: String?
    var isSelected: Bool
    var subCategoryId: String?
    
    init(entity: CategoryEntity,
         isSelected: Bool = false) {
        
        categoryName = entity.nameEn
        subCategoryId = entity.id
        self.isSelected = isSelected
    }
    
//    init(entity: CategoriesOfProduct) {
//        categoryName = entity.name
//        subCategoryId = entity.id
//    }
}
