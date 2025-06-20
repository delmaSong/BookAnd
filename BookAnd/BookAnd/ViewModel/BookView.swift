//
//  BookView.swift
//  BookAnd
//
//  Created by Delma Song on 6/20/25.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	let book: Book
	
}

#Preview {
	NavigationStack {
		BookView(book: Book(
			isbn: "1234567890",
			title: "샘플 도서 제목",
			publisher: "샘플 출판사",
			author: "샘플 저자",
			coverImageURL: "",
			categoryName: "문학 > 소설",
			categories: ["문학", "소설"]
		))
	}
}
