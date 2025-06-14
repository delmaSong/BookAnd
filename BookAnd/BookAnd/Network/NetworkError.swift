//
//  NetworkError.swift
//  BookAnd
//
//  Created by Delma Song on 6/14/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .invalidResponse:
            return "서버로부터 잘못된 응답을 받았습니다."
        case .decodingError:
            return "응답 데이터 디코딩에 실패했습니다."
        case .serverError(let message):
            return "서버 에러: \(message)"
        case .unknown:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
} 
