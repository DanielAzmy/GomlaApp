//
//  CategoryRepository.swift
//  GomlaApp
//
//  Created by Daniel azmy on 01/06/2026.
//


protocol CategoryRepositoryProtocol{
    func getCategoryData(id: String, completion: @escaping (Result<CategoryResponse, Error>) -> Void)
    func getCategoryProducts(id: String, completion: @escaping (Result<CategoryProductsResponse, Error>) -> Void)
}

final class CategoryRepository: CategoryRepositoryProtocol{
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getCategoryData(id: String, completion: @escaping (Result<CategoryResponse, Error>) -> Void) {
        let endpoint = CategoriesEndpoint.categories(id: id)
        Task {
            do {
                let response: BaseResponse<CategoryResponse> = try await apiClient.request(endpoint)
                guard let data = response.data else { return }
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getCategoryProducts(id: String, completion: @escaping (Result<CategoryProductsResponse, any Error>) -> Void) {
        let endpoint = CategoriesEndpoint.products(id: id)
        Task {
            do {
                let response: BaseResponse<CategoryProductsResponse> = try await apiClient.request(endpoint)
                guard let data = response.data else { return }
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
