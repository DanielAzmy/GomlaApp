//
//  HomeRepositoryProtocol.swift
//  GomlaApp
//
//  Created by Daniel azmy on 19/05/2026.
//


protocol ProductRepositoryProtocol{
    func getProductData(id: String) async throws -> BaseResponse<ProductDetailsModel>
}

final class ProductRepository: ProductRepositoryProtocol{
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getProductData(id: String) async throws -> BaseResponse<ProductDetailsModel> {
        let endpoint = HomeEndpoints.details(id: id)
        return try await apiClient.request(endpoint)
    }
}
