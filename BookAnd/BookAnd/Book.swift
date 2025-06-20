//
//  Book.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation

struct BookResponse: Codable {
	let books: [Book]
	
	enum CodingKeys: String, CodingKey {
		case books = "item"
	}
}

struct Book: Equatable, Codable {
	/// 도서 정보 구분짓는 유일키
	let isbn: String
	let title: String
	let publisher: String
	let author: String
	let coverImageURL: String
	let categoryName: String
	var categories: [String]
	
	enum CodingKeys: String, CodingKey {
		case title
		case publisher
		case author
		case isbn
		case coverImageURL = "cover"
		case categoryName
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.isbn = try container.decode(String.self, forKey: .isbn)
		self.title = try container.decode(String.self, forKey: .title)
		self.publisher = try container.decode(String.self, forKey: .publisher)
		self.author = try container.decode(String.self, forKey: .author)
		self.coverImageURL = try container.decode(String.self, forKey: .coverImageURL)
		self.categoryName = try container.decode(String.self, forKey: .categoryName)
		self.categories = self.categoryName.components(separatedBy: ">")
	}
	
	init(
		isbn: String,
		title: String,
		publisher: String,
		author: String,
		coverImageURL: String,
		categoryName: String,
		categories: [String]
	) {
		self.isbn = isbn
		self.title = title
		self.publisher = publisher
		self.author = author
		self.coverImageURL = coverImageURL
		self.categoryName = categoryName
		self.categories = categories
	}
}
