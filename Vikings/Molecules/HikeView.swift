//
//  HikeView.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 13.09.2023.
//

import SwiftUI

struct HikeView: View {
    var widthCard: CGFloat = .widthCard
    var heightCard: CGFloat = .heightCard
    var lineWidth: CGFloat = .lineWidth
    var cornerRadius: CGFloat = .cornerRadius
    var shadowRadius: CGFloat = .shadowRadius
    var authorName: String = .authorName
    
    var body: some View {
        avatarView()
    }
}

private extension HikeView {
    
    func avatarView() -> some View {
        AsyncImage(url: .mockLoadingUrl!) { image in
            ZStack(alignment: .bottom) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: widthCard, height: heightCard)
                    .clipped()
                    .cornerRadius(.cornerRadius)
                    .borderRectangle(LinearGradient.kingGradient, cornerRadius, lineWidth)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: shadowRadius,
                        x: .shawodOffsetX,
                        y: .shawodOffsetY
                )

            }
            
        } placeholder: {
            ShimmeringView()
                .frame(width: widthCard, height: heightCard)
                .background(
                    LinearGradient.kingGradient.opacity(0.4)
                        .borderRectangle(.pink, .cornerRadius, .lineWidth)
                )
                .cornerRadius(.cornerRadius)
        }
    }
}

// MARK: - Previews

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView()
    }
}

// MARK: - Constants

private extension CGFloat {

    static let widthCard: CGFloat = 250
    static let heightCard: CGFloat = 230
    static let cornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 4
    static let lineWidth: CGFloat = 3
    static let shawodOffsetX: CGFloat = 8
    static let shawodOffsetY: CGFloat = 16
}

private extension String {
    
    static let authorName = "MightyK1ngRichard"
}
