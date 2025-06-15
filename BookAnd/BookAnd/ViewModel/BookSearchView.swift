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
		}
		.navigationTitle("도서 추가")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(false)
        .onChange(of: viewModel.books) { books in
        }
    }
}

#Preview {
    NavigationStack {
        BookSearchView()
    }
} 
