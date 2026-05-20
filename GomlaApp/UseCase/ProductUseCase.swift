//
//  HomeUseCaseProtocol.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//


protocol ProductUseCaseProtocol{
    func getProducData(id: String) async throws -> BaseResponse<ProductDetailsModel>
}

final class ProductUseCase: ProductUseCaseProtocol{
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProducData(id: String) async throws -> BaseResponse<ProductDetailsModel> {
        try await repository.getProductData(id: id)
    }
}
