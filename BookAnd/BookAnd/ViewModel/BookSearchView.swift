//
//  BookSearchView.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import SwiftUI
import Combine

struct BookSearchView: View {
    @State private var inputText: String = ""
    @StateObject private var viewModel = BookSearchViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("제목, 저자, 출판사 등을 입력하세요", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onSubmit {
                    if !inputText.isEmpty {
                        viewModel.searchBooks(query: inputText)
                    }
				}
			
			if !viewModel.books.isEmpty {
				List {
					ForEach(viewModel.books, id: \.isbn) { book in
						NavigationLink(destination: BookView()) {
							HStack(spacing: 12) {
								AsyncImage(url: URL(string: book.coverImageURL)) { phase in
									switch phase {
									case .empty:
										Color.gray
									case .success(let image):
										image.resizable()
											.aspectRatio(contentMode: .fit)
									case .failure:
										Color.gray
									@unknown default:
										Color.gray
									}
								}
								.frame(width: 60, height: 80)
								.cornerRadius(4)
								
								VStack(alignment: .leading, spacing: 4) {
									Text(book.title)
										.font(.headline)
										.lineLimit(2)
									
									Text(book.author)
										.font(.subheadline)
										.foregroundColor(.gray)
									
									Text(book.publisher)
										.font(.caption)
										.foregroundColor(.gray)
								}
							}
							.padding(.vertical, 8)
						}
						.buttonStyle(PlainButtonStyle())
					}
				}
				.listStyle(PlainListStyle())
				.onAppear {
					if let _ = viewModel.books.last {
						loadMoreContent()
					}
				}
			} else {
				Spacer()
			}
		}
		.navigationTitle("도서 추가")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(false)
	}
	
	private func loadMoreContent() {
		guard !viewModel.isLoading else { return }
		viewModel.searchBooks(query: inputText)
	}
}

#Preview {
    NavigationStack {
        BookSearchView()
    }
} 
