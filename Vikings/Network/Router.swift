//
//  Router.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 18.09.2023.
//

import Foundation

// MARK: ROUTER

enum Router {
    static let baseUrl = "http://localhost:7070/api/v3"
    
    case cities
    
    var endpoint: String {
        switch self {
        case .cities: return Self.baseUrl + "/cities"
        }
    }
}

// MARK: METHODs

enum Method: String {
    case get  = "GET"
    case post = "POST"
}
