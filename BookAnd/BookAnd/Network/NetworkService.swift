//
//  NetworkService.swift
//  BookAnd
//
//  Created by Delma Song on 6/14/25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        guard let request = endpoint.makeURLRequest() else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
} 
