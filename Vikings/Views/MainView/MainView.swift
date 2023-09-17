//
//  MainView.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 13.09.2023.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let width = $0.size.width
                CitiesScroll(width)
            }
        }
    }
}

// MARK: - ContentView

private extension MainView {
    
    func VikingsScroll() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0...10, id: \.self) { card in
                    AuthorCircle(
                        username: "mightyK1ngRichard",
                        imageConfiguration: .imageConfiguration
                    ) {
                        print("tap")
                    }
                    
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func CitiesScroll(_ width: CGFloat) -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VikingsScroll()
            
            LazyVGrid(
                columns: [
                    GridItem(
                        .fixed(width / .divider - .gridSpacer / 2),
                        spacing: .gridSpacer
                    ),
                    GridItem(
                        .fixed(width / .divider - .divider / 2),
                        spacing: .zero
                    )
                ],
                spacing: 5
            ) {
                ForEach(0...15, id: \.self) {_ in
                    Rectangle()
                        .fill(LinearGradient.kingGradient.opacity(0.4))
                        .frame(height: 150)
                        .cornerRadius(20)
                    
                }
            }
        }
    }
}

// MARK: - Image Configuration

private extension MKRImageView.Configuration {
    
    static var imageConfiguration: Self = .basic(
        kind: .custom(
            url: .mockLoadingUrl,
            mode: .fill,
            imageSize: .imageSize,
            imageCornerRadius: .imageCornerRadius,
            imageBorderWidth: .zero,
            imageBorderColor: nil,
            placeholderLineWidth: .zero
        )
    )
}

// MARK: - Constants

private extension CGSize {
    
    static let imageSize = CGSize(edge: 82)
}

private extension CGFloat {
    
    static let widthCard: CGFloat = 100
    static let divider: CGFloat = 2
    static let gridSpacer: CGFloat = 5
    static let heightCard: CGFloat = 100
    static let lineWidth: CGFloat = 2.5
    static let shadowRadius: CGFloat = 13
    static let imageCornerRadius: CGFloat = 41
}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
