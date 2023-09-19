//
//  MainViewModel.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 17.09.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var cityViewModel = CityViewModel()
    @Published var authorViewModel = AuthorViewModel()
}

// MARK: View Models

struct CityViewModel {
    var cities: [CityModel] = []
}

struct AuthorViewModel {
    var authors: [AuthorModel] = []
}

// MARK: Codable Models

struct CityModel: Identifiable, Codable {
    var id          : UInt = .zero
    var cityName    : String? = ""
    var imageURL    : URL? = nil
    var description : String? = nil
}

struct AuthorModel: Identifiable, Codable {
    var id          : UInt = .zero
    var authorName  : String = ""
    var post        : String? = nil
    var imageURL    : URL? = nil
}
