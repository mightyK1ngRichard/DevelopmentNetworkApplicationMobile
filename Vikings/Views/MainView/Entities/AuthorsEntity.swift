//
//  AuthorsEntity.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 19.09.2023.
//

import Foundation

struct AuthorsEntity: Decodable {
    let authors: [AuthorEntity]
}

struct AuthorEntity: Decodable {
    let id         : UInt
    let authorName : String?
    let profession : String?
    let birthday   : String?
    let imageURL   : String?
}

extension AuthorsEntity {
    
    var mapper: AuthorViewModel {
        AuthorViewModel(
            authors: authors.map { AuthorModel(
                id: $0.id,
                authorName: $0.authorName ?? "Аноним",
                post: $0.profession,
                imageURL: $0.imageURL?.toURL)
            }
        )
    }
}
