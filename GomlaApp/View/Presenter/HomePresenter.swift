//
//  HomePresenter.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//

import Foundation

final class HomePresenter{
    
    private let useCase: HomeUseCaseProtocol
    weak var view: HomeViewProtocol?
    
    init(
        view: HomeViewProtocol,
        useCase: HomeUseCaseProtocol = HomeUseCase(repository: HomeRepository())
    ) {
        self.view = view
        self.useCase = useCase        
    }
    
    func fetchHomeData() {
            Task {
                do {
                    let response = try await useCase.getHomeData(
                        city: "%D8%A7%D9%84%D9%82%D8%A7%D9%87%D8%B1%D9%87",
                        area: "%D8%A7%D9%84%D8%B8%D8%A7%D9%87%D8%B1"
                    )

                    await MainActor.run {
                        guard let data = response.data else { return }
                        self.view?.showHomeData(data)
                    }

                } catch {
                    await MainActor.run {
                        self.view?.showError(error.localizedDescription)
                    }
                }
            }
        }
}
