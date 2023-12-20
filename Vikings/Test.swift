//
//  Test.swift
//  Vikings
//
//  Created by Dmitriy Permyakov on 26/10/2023.
//
import UIKit
import SwiftUI

struct Test: View {

    var body: some View {
        VStack {
            Text("Привет")
                .onTapGesture {
                    
                }
        }
    }



    private func FetchHikes() {
        NetworkService.shared.request(
            router: .hikes,
            method: .get,
            type: HikesEntity.self, 
            parameters: nil
        ) { result in
            switch result {
            case .success(let hikes):
                print(hikes.mapper.hikes.filter { [1].contains($0.author.id) })
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    Test()
//        .environmentObject(MainViewModel())
}

