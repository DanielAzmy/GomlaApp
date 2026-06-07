//
//  ProductDetailsPresenter.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//

import Foundation

final class ProductDetailsPresenter{
    
    private let useCase: ProductUseCaseProtocol
    weak var view: ProductDetailsView?
    
    private var id: String
    
    init(
        view: ProductDetailsView,
        useCase: ProductUseCaseProtocol = ProductUseCase(repository: ProductRepository()),
        id: String
    ) {
        self.view = view
        self.useCase = useCase
        self.id = id
    }
    
    func fetchProductData() {
            Task {
                do {
                    let response = try await useCase.getProducData(id: id)
                    await MainActor.run {
                        guard let data = response.data else { return }
                        self.view?.setProductData(with: data)
                    }
                } catch {
                    await MainActor.run {
                        print(error.localizedDescription)
                    }
                }
            }
        }
}
