//
//  CitiesEntity.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 19.09.2023.
//

import Foundation

struct CitiesEntity: Decodable {
    var cities: [CitiyEntity]
}

struct CitiyEntity: Decodable {
    var id: UInt
    var cityName: String?
    var statusID: UInt
    var description: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, description
        case cityName = "city_name"
        case statusID = "status_id"
        case imageURL = "image_url"
    }
}


extension CitiesEntity {
    
    var mapper: CityViewModel {
        CityViewModel(
            cities: self.cities.map {
                CityModel(
                    id: $0.id,
                    cityName: $0.cityName,
                    imageURL: $0.imageURL.toURL,
                    description: $0.description
                )
            }
        )
    }
}
