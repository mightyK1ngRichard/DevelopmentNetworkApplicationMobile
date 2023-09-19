//
//  MainView.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 13.09.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let cityWidth = proxy.size.width  / .divider - .gridSpacer / .divider - .borderWidth * 4
                ScrollView(showsIndicators: false) {
                    AuthorsScroll()
                    CitiesScroll(cityWidth)
                }
            }
        }
        .onAppear(perform: FetchData)
        .environmentObject(viewModel)
    }
}

// MARK: - MainView

private extension MainView {
    
    /// Скролл вью авторов
    func AuthorsScroll() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.authorViewModel.authors) { author in
                    AuthorCircle(
                        username: author.authorName,
                        imageConfiguration: .authorImageConfiguration(url: author.imageURL)
                    ) {
                        print("author: \(author.id)")
                    }
                }
            }
            .padding(.vertical, .lineWidth * 2)
        }
    }
    
    /// Скролл вью городов
    @ViewBuilder
    func CitiesScroll(_ cityWidth: CGFloat) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(
                        .fixed(cityWidth),
                        spacing: .gridSpacer
                    ),
                    GridItem(
                        .fixed(cityWidth),
                        spacing: .zero
                    )
                ],
                spacing: 10
            ) {
                ForEach(viewModel.cityViewModel.cities) { city in
                    NavigationLink {
                        DetailCityView(city: city)
                        
                    } label: {
                        CityView(
                            cityName: city.cityName ?? .emptyCity,
                            imageConfiguration: .cityImageConfiguration(
                                url: city.imageURL,
                                imageSize: CGSize(width: cityWidth, height: 150)
                            )
                        )
                        .borderRectangle(.primary, .cityImageCornerRadius, .borderWidth)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 5)
            .padding(.top, 10)
        }
    }
}

// MARK: - Network

private extension MainView {
    func FetchData() {
        NetworkService.shared.request(
            router: .cities,
            method: .get,
            type: CitiesEntity.self,
            parameters: nil) { result in
                switch result {
                case .success(let city):
                    viewModel.cityViewModel = city.mapper
                case .failure(let error):
                    print(error)
                }
            }
        DispatchQueue.main.async {
            viewModel.cityViewModel = .data
            viewModel.authorViewModel = .data
        }
    }
}

// MARK: - Image Configuration

private extension MKRImageView.Configuration {
    
    static func authorImageConfiguration(
        url: URL?
    ) -> Self {
        .basic(
            kind: .custom(
                url: url,
                mode: .fill,
                imageSize: .imageSize,
                imageCornerRadius: .imageCornerRadius,
                imageBorderWidth: .zero,
                imageBorderColor: nil,
                placeholderLineWidth: .zero,
                placeholderImageSize: min(CGSize.imageSize.width, 30)
            )
        )
    }
    
    static func cityImageConfiguration(
        url: URL?,
        imageSize: CGSize
    ) -> Self {
        .basic(
            kind: .custom(
                url: url,
                mode: .fill,
                imageSize: imageSize,
                imageCornerRadius: .cityImageCornerRadius,
                imageBorderWidth: .zero,
                imageBorderColor: nil,
                placeholderLineWidth: .cityPlaceholderLineWidth,
                placeholderImageSize:  min(imageSize.width, 25)
            )
        )
    }
}

// MARK: - Constants

private extension CGSize {
    
    static let imageSize = CGSize(edge: 82)
}

private extension String {
    
    static let emptyCity = "Название отсутсвует"
}

private extension CGFloat {
    
    static let widthCard: CGFloat = 100
    static let divider: CGFloat = 2
    static let gridSpacer: CGFloat = 5
    static let heightCard: CGFloat = 100
    static let lineWidth: CGFloat = 2.5
    static let borderWidth: CGFloat = 1
    static let shadowRadius: CGFloat = 13
    static let imageCornerRadius: CGFloat = CGSize.imageSize.width / 2
    static let cityImageCornerRadius: CGFloat = 20
    static let cityPlaceholderLineWidth: CGFloat = 1
}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(MainViewModel())
    }
}

// MARK: - Test data

private extension CityViewModel {
    
    static let description = "Просто какой-то набор слов для описания такого города. Правда надо просто что-то очень много и много писать, но я не могу понять, что я ещё могу придумать для такого города. Ладно, пофиг. Крч вот тычка тычка тычка, карта карта, сююююда, мурлок и победа. СИИИИИУ"
    
    static let data = CityViewModel(cities: [
        CityModel(id: 0, cityName: "Просто город 1", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 1, cityName: "Просто город 2", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 2, cityName: "Просто город 3", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 3, cityName: "Просто город 4", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 4, cityName: "Просто город 5", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 5, cityName: "Просто город 6", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 6, cityName: "Просто город 7", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 7, cityName: "Просто город 8", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 8, cityName: "Просто город 9", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 9, cityName: "Просто город 10", imageURL: .mockLoadingUrl, description: description),
        CityModel(id: 10, cityName: "Просто город 11", imageURL: .mockLoadingUrl, description: nil),
    ])
}

private extension AuthorViewModel {
    
    static let data = AuthorViewModel(authors: [
        AuthorModel(id: 0, authorName: "mightyKingRichard", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 1, authorName: "king", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 2, authorName: "legend", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 3, authorName: "richard", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 4, authorName: "poly", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 5, authorName: "mark", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 6, authorName: "blackElshad", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 7, authorName: "aosimo", post: "Директор", imageURL: .mockLoadingUrl),
        AuthorModel(id: 8, authorName: "legend", post: "Директор", imageURL: .mockLoadingUrl),
    ])
}
