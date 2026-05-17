//
//  HomeUseCase.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import Foundation
protocol HomeUseCaseProtocol{
    func getHomeData(city: String, area: String) async throws -> BaseResponse<HomeDataModel>
}

final class HomeUseCase: HomeUseCaseProtocol{
    
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getHomeData(city: String, area: String) async throws -> BaseResponse<HomeDataModel> {
        try await repository.getHomeData(city: city, area: area)
    }
}
