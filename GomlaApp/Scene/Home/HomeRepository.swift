//
//  HomeRepository.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import Foundation

protocol HomeRepositoryProtocol{
    func getHomeData(city: String, area: String) async throws -> BaseResponse<HomeDataModel>
}

final class HomeRepository: HomeRepositoryProtocol{
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getHomeData(city: String, area: String) async throws -> BaseResponse<HomeDataModel> {
        let endpoint = HomeEndpoints.home(city: city, area: area)
        return try await apiClient.request(endpoint)
    }
}
