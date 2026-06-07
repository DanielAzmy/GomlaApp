//
//  HomeUseCaseProtocol.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//


protocol CategoryUseCaseProtocol{
    func getProducData(id: String)
    func getProducs(id: String)
}

class CategoryUseCase: CategoryUseCaseProtocol{

    //MARK: - properties
    var presenter: CategoryPresenterProtocol?
    var repository: CategoryRepositoryProtocol?
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProducData(id: String) {
        repository?.getCategoryData(id: id) { result in
            switch result {
            case .success(let data):
//                guard let cat = data.categories else {
//                    // TODO: - Handle null
////                    self.presenter.categoriesNotFound()
//                    return }
                self.presenter?.didFetchCategoryDetails(with: data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getProducs(id: String) {
        repository?.getCategoryProducts(id: id) { result in
            switch result {
            case .success(let data):
//                guard let proucts = data.proucts else {
//                    // TODO: - Handle null
////                    self.presenter.categoriesNotFound()
//                    return }
                self.presenter?.didFetchCategoryProducts(with: data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

