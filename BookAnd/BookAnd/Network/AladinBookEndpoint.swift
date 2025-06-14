//
//  AladinBookEndpoint.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation

enum AladinBookEndpoint: APIEndpoint {
    /// 책 검색
	/// - query: 검색어
	/// - maxResults: 결과 갯수
	case search(query: String, maxResults: Int = 10)
    /// 책 상세정보
	///  - isbn: 책을 구분짓는 유일한 값으로, 조회 할 책의 isbn
	case detail(isbn: String)
    
	var baseURL: String {
		return "http://www.aladin.co.kr/ttb/api"
	}
	
    var path: String {
        switch self {
        case .search:
            return "/ItemSearch.aspx"
        case .detail:
            return "/ItemLookUp.aspx"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        var params: [String: String] = [
            "ttbkey": AppConfig.aladinTTBKey,
            "output": "js",
            "Version": "20131101",
            "cover": "big"
        ]
        
        switch self {
        case .search(let query, let maxResults):
            params["Query"] = query
            params["MaxResults"] = "\(maxResults)"
            
        case .detail(let isbn):
            params["ItemId"] = isbn
            params["ItemIdType"] = "ISBN13"
        }
        
        return params
    }
} 
