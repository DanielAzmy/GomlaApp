//
//  CategoryPresenter.swift
//  GomlaApp
//
//  Created by Daniel azmy on 01/06/2026.
//

import Foundation

protocol CategoryPresenterProtocol: AnyObject{
    func didFetchCategoryDetails(with entity: CategoryResponse?)
    func didFetchCategoryProducts(with entity: CategoryProductsResponse?)
}

final class CategoryPresenter{
    
    // MARK: - properties
    weak var view: CategoryDetailsViewProtocol?
    
    init(view: CategoryDetailsViewProtocol) {
        self.view = view
    }
}

extension CategoryPresenter: CategoryPresenterProtocol{
    func didFetchCategoryProducts(with entity: CategoryProductsResponse?) {
        guard let data = entity?.products else {return}
        view?.setCategoryProducts(with: data)
    }
    
    func didFetchCategoryDetails(with entity: CategoryResponse?) {
        guard let data = entity?.categories else {return}
        view?.setCategories(with: SubCategoriesViewModel(categories: data))
    }
}
