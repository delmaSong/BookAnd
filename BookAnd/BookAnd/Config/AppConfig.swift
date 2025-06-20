//
//  AppConfig.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import Foundation

enum AppConfig {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
} 

extension AppConfig {
	static var aladinTTBKey: String {
		return try! value(for: "ALADIN_TTB_KEY")
	}
}
