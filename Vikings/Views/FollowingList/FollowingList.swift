//
//  FollowingList.swift
//  Vikings
//
//  Created by Dmitriy Permyakov on 25/10/2023.
//

import SwiftUI

struct FollowingList: View {
    @StateObject var viewModel = FollowerViewModel()

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            ScrollView {
                VStack {
                    ForEach(viewModel.hikesViewModel.hikes) { hike in
                        HikeView(hike: hike, width: width)
                    }
                }
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.hikesViewModel = .mockModel
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FollowingList()
        .environmentObject(FollowerViewModel())
}

// MARK: - Mock data

private extension HikesViewModel {

    static var mockModel = HikesViewModel(hikes: [
        HikeModel(
            id: 0,
            hikeName: "Поход 1",
            dateStartHike: "14-03-2003",
            dateApprove: "14-03-2003",
            author: .init(id: 0, authorName: "King", post: "Backend", imageURL: .mockLoadingUrl),
            leader: "Leader похода 1",
            description: "Описание с каким-то бла бла, бой бой, тычка тычка, ура победа",
            destinationHikes: [
                DestinationHikesModel(id: 0, serialNumber: 1, city: .init(
                    id: 0, cityName: "Город 1", imageURL: .mockDragonUrl, description: nil)
                ),
                DestinationHikesModel(id: 1, serialNumber: 2, city: .init(
                    id: 1, cityName: "Город 2", imageURL: .mockLoadingUrl, description: nil)
                ),
                DestinationHikesModel(id: 2, serialNumber: 3, city: .init(
                    id: 2, cityName: "Город 3", imageURL: .mockDragonUrl, description: nil)
                ),
            ]
        ),
        HikeModel(
            id: 1,
            hikeName: "Поход 2",
            dateStartHike: "14-03-2003",
            dateApprove: "14-03-2003",
            author: .init(id: 0, authorName: "King 2", post: "Backend 2", imageURL: .mockLoadingUrl),
            leader: "Leader похода 2",
            description: "Описание с каким-то бла бла, бой бой, тычка тычка, ура победа",
            destinationHikes: [
                DestinationHikesModel(id: 0, serialNumber: 1, city: .init(
                    id: 0, cityName: "Город 1", imageURL: .mockDragonUrl, description: nil)
                ),
                DestinationHikesModel(id: 1, serialNumber: 2, city: .init(
                    id: 1, cityName: "Город 2", imageURL: .mockLoadingUrl, description: nil)
                ),
                DestinationHikesModel(id: 2, serialNumber: 3, city: .init(
                    id: 2, cityName: "Город 3", imageURL: .mockDragonUrl, description: nil)
                ),
            ]
        )
    ])
}
