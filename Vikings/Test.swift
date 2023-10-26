//
//  Test.swift
//  Vikings
//
//  Created by Dmitriy Permyakov on 26/10/2023.
//

import SwiftUI

struct Test: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        VStack {
            Text("Привет")
        }
        .onAppear {
            viewModel.currentUser = .init(id: 1, authorName: "", post: "", imageURL: .mockLoadingUrl)
//            FetchUserSubscriptions()
            FetchHikes()
        }
    }

    private func FetchUserSubscriptions() {
        NetworkService.shared.request(
            router: .userSubscriptions,
            method: .get,
            type: UserSubscriptionsEntity.self,
            parameters: ["user_id": viewModel.currentUser.id]
        ) { result in
            switch result {
            case .success(let userSubscriptions):
                NetworkService.shared.request(
                    router: .hikes,
                    method: .get,
                    type: HikesEntity.self,
                    parameters: nil
                ) { result in
                    switch result {
                    case .success(let hikes):
                        print(hikes.mapper.hikes.filter {
                            userSubscriptions.subscriptionsIdArray.contains(Int($0.author.id))
                        })
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
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
        .environmentObject(MainViewModel())
}

