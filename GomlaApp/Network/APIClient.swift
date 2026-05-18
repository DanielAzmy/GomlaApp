//
//  APIClientProtocol.swift
//  GomlaApp
//
//  Created by Daniel azmy on 12/05/2026.
//


import Foundation
import Alamofire

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = Session(configuration: configuration)
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        let response = await session.request(
            endpoint.url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
            .validate()
            .serializingDecodable(T.self)
            .response
        
        switch response.result {
            
        case .success(let value):
            return value
            
        case .failure(let error):
            throw handleError(error, response: response)
        }
    }
    
    private func handleError<T>(_ error: AFError, response: DataResponse<T, AFError>) -> Error {
        if let data = response.data,
           let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            return APIClientError.serverError(apiError.message)
        }
        
        if let underlyingError = error.underlyingError {
            return APIClientError.networkError(underlyingError.localizedDescription)
        }
        
        switch error {
        case .sessionTaskFailed(let urlError as URLError) where urlError.code == .notConnectedToInternet:
            return APIClientError.networkError("No internet connection.")
        case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
            return APIClientError.serverError("Server returned an error (Code \(code)).")
        default:
            return APIClientError.unknown("Unexpected error occurred.")
        }
    }
    
    private func logResponse<T>(_ response: DataResponse<T, AFError>, endpoint: Endpoint) {
        #if DEBUG
        print("""
        REQUEST:
        URL: \(endpoint.url)
        METHOD: \(endpoint.method.rawValue)
        PARAMETERS: \(String(describing: endpoint.parameters))
        HEADERS: \(String(describing: endpoint.headers))
        
        RESPONSE:
        STATUS CODE: \(response.response?.statusCode ?? 0)
        RESULT: \(response.result)
        """)
        #endif
    }
}

struct APIError: Decodable {
    let message: String
}

enum APIClientError: Error {
    case networkError(String)
    case serverError(String)
    case unknown(String)
}



