//
//  TSubCategoriesViewModel.swift
//  GomlaApp
//
//  Created by Daniel azmy on 25/05/2026.
//


class SubCategoriesViewModel {
    
    private var categories: [CategoryEntity]
    var viewModels: [SubCategoryViewModel] = [SubCategoryViewModel]()
    
    init(categories: [CategoryEntity]) {
        self.categories = categories
        setupViewModels()
    }
    
    private func setupViewModels() {
        categories.forEach({
            viewModels.append(SubCategoryViewModel(entity: $0))
        })
    }
    
}
