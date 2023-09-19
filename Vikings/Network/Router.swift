//
//  Router.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 18.09.2023.
//

import Foundation

// MARK: ROUTER

enum Router {
    case cities
    case authors
}

// MARK: METHODs

enum Method: String {
    case get  = "GET"
    case post = "POST"
}

// MARK: ENDPOINTS

extension Router {
    
    var endpoint: String {
        switch self {
        case .cities: return .baseUrl + .cities
        case .authors: return .baseUrl + .authors
        }
    }
}

// MARK: CONSTANTS

private extension String {
    
    static let baseUrl = "http://localhost:7070/api/v3"
    static let cities = "/cities"
    static let authors = "/authors"
}
