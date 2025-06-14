//
//  APIEndpoint.swift
//  BookAnd
//
//  Created by Delma Song on 6/14/25.
//

import Combine
import Foundation

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

protocol APIEndpoint {
	var baseURL: String { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var headers: [String: String]? { get }
	var parameters: [String: Any]? { get }
    
    func makeURLRequest() -> URLRequest?
}

extension APIEndpoint {
	var headers: [String: String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String: Any]? {
		return nil
	}
    
    func makeURLRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL + path)
        
        if method == .get, let parameters = parameters {
            urlComponents?.queryItems = parameters.map { 
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        if method != .get, let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                return nil
            }
        }
        
        return request
    }
}
