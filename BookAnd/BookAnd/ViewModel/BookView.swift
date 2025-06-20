//
//  BookView.swift
//  BookAnd
//
//  Created by Delma Song on 6/20/25.
//

import SwiftUI

struct BookView: View {
	let book: Book
	
	var body: some View {
		ZStack {
			// 블러 처리된 배경 이미지
			AsyncImage(url: URL(string: book.coverImageURL)) { phase in
				switch phase {
				case .empty:
					Color.gray.opacity(0.1)
				case .success(let image):
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: UIScreen.main.bounds.width)
						.blur(radius: 20)
						.opacity(0.5)
				case .failure:
					Color.gray.opacity(0.1)
				@unknown default:
					Color.gray.opacity(0.1)
				}
			}
			.ignoresSafeArea()
			
			// 메인 콘텐츠
			ScrollView {
				VStack(spacing: 20) {
					// 책 표지 이미지
					AsyncImage(url: URL(string: book.coverImageURL)) { phase in
						switch phase {
						case .empty:
							Rectangle()
								.fill(Color.gray.opacity(0.3))
								.frame(width: 200, height: 280)
						case .success(let image):
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(maxWidth: 200, maxHeight: 280)
						case .failure:
							Rectangle()
								.fill(Color.gray.opacity(0.3))
								.frame(width: 200, height: 280)
						@unknown default:
							Rectangle()
								.fill(Color.gray.opacity(0.3))
								.frame(width: 200, height: 280)
						}
					}
					.cornerRadius(8)
					.shadow(radius: 10)
					.padding(.top, 40)
					
					// 책 정보
					VStack(alignment: .leading, spacing: 12) {
						Text(book.title)
							.font(.title2)
							.fontWeight(.bold)
							.multilineTextAlignment(.leading)
							.foregroundColor(.primary)
							.fixedSize(horizontal: false, vertical: true)
						
						Divider()
							.background(Color.primary.opacity(0.3))
						
						InfoRow(title: "저자", value: book.author)
						InfoRow(title: "출판사", value: book.publisher)
						InfoRow(title: "ISBN", value: book.isbn)
						
						if !book.categories.isEmpty {
							InfoRow(title: "카테고리", value: book.categories.joined(separator: " > "))
						}
					}
					.padding(20)
					.background(
						RoundedRectangle(cornerRadius: 16)
							.fill(.ultraThinMaterial)
							.shadow(radius: 2)
					)
					
				}
				.padding(.horizontal, 10)
				.frame(width: UIScreen.main.bounds.width)
			}
		}
		.navigationTitle("도서 상세")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct InfoRow: View {
	let title: String
	let value: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(title)
				.font(.caption)
				.foregroundColor(.gray)
			
			Text(value)
				.font(.body)
				.fixedSize(horizontal: false, vertical: true)
				.multilineTextAlignment(.leading)
		}
	}
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
