//
//  Book.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation

struct BookResponse {
	let books: [Book]
	
	enum CodingKeys: String, CodingKey {
		case books = "item"
	}
}

struct Book {
	let title: String
	let publisher: String
	let author: String
	let isbn13: String
	let coverImageURL: String
	let categoryName: String
	var categories: [String]
	
	enum CodingKeys: String, CodingKey {
		case title
		case publisher
		case author
		case isbn13
		case coverImageURL = "cover"
		case categoryName
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.title = try container.decode(String.self, forKey: .title)
		self.publisher = try container.decode(String.self, forKey: .publisher)
		self.author = try container.decode(String.self, forKey: .author)
		self.isbn13 = try container.decode(String.self, forKey: .isbn13)
		self.coverImageURL = try container.decode(String.self, forKey: .coverImageURL)
		self.categoryName = try container.decode(String.self, forKey: .categoryName)
		self.categories = self.categoryName.components(separatedBy: ">")
	}
}
