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
    
    init(repository: BookRepository = AladinBookRepository()) {
        self.repository = repository
    }
    
    func searchBooks(query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        error = nil
        
		repository.searchBooks(query: query, maxResults: 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] books in
                self?.books = books
            }
            .store(in: &cancellables)
    }
} 
