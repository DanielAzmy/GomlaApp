//
//  CategoryBuilder.swift
//  GomlaApp
//
//  Created by Daniel azmy on 03/06/2026.
//

import UIKit

final class CategoryBuilder {
    
    static func build(category: CategoryModel) -> UIViewController {
        
        // MARK: - Dependencies
        let repository = CategoryRepository()
        let useCase = CategoryUseCase(repository: repository)
        let viewController = CategoryDetailsViewController(category: category)
        let presenter = CategoryPresenter(view: viewController)
        let router = CategoryRouter()
        
        // MARK: - Wire dependencies
        useCase.presenter = presenter
        viewController.presenter = presenter
        viewController.interactor = useCase
        viewController.router = router
        
        return viewController
    }
}


protocol CategoryRouterProtocol: AnyObject {
    func navigateToDetails()
    
}

final class CategoryRouter: CategoryRouterProtocol {
    func navigateToDetails() {
        
    }
    
}






class CategoryProductDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = CategoryBuilder.build(category: CategoryModel(id: "", imageUrl: "", name: ""))
        
        
    }
}
