//
//  BookSearchViewModel.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation
import Combine

final class BookSearchViewModel: ObservableObject {
    private let repository: BookRepository
    private var cancellables = Set<AnyCancellable>()
    
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
	
	private let maxPage: Int = 5
	private var currentPage: Int = 1
    private var currentQuery: String = ""
    
    init(repository: BookRepository = AladinBookRepository()) {
        self.repository = repository
    }
    
    func searchBooks(query: String) {
        guard !query.isEmpty else { return }
        
		if self.currentQuery != query {
			self.currentQuery = query
			self.currentPage = 1
			self.books.removeAll()
        }
        
		guard self.currentPage <= self.maxPage else { return }
        
		self.isLoading = true
		self.error = nil
        
		self.repository.searchBooks(
			query: query,
			currentPage: self.currentPage
		)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] newBooks in
                guard let self = self else { return }
				
                self.books.append(contentsOf: newBooks)
                self.currentPage += 1
            }
			.store(in: &cancellables)
    }
} 
