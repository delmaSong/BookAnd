//
//  BookRepository.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation
import Combine

protocol BookRepository {
    func searchBooks(query: String, maxResults: Int) -> AnyPublisher<[Book], NetworkError>
    func featchBookDetail(isbn: String) -> AnyPublisher<Book, NetworkError>
}

final class AladinBookRepository: BookRepository {
	private let networkService: NetworkServiceProtocol
	
	init(networkService: NetworkServiceProtocol = NetworkService()) {
		self.networkService = networkService
	}
	
	func searchBooks(query: String, maxResults: Int) -> AnyPublisher<[Book], NetworkError> {
		let endpoint = AladinBookEndpoint.search(query: query, maxResults: maxResults)
		return networkService.request(endpoint)
			.map { (response: BookResponse) in
				return response.books
			}
			.eraseToAnyPublisher()
	}
	
	func featchBookDetail(isbn: String) -> AnyPublisher<Book, NetworkError> {
		let endpoint = AladinBookEndpoint.detail(isbn: isbn)
		return networkService.request(endpoint)
	}
}
