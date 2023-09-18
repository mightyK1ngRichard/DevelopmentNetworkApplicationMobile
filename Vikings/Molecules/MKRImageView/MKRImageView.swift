//
//  MKRImageView.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 17.09.2023.
//

import SwiftUI

struct MKRImageView: View {
    var configuration: Configuration = .clear
    var handler: MKREmptyBlock?
    
    var body: some View {
        if let url = configuration.url {
            AsyncImage(url: url) { image in
                image
                    .resizeImage(
                        mode: configuration.mode,
                        width: configuration.imageSize.width,
                        height: configuration.imageSize.height
                    )
                    .cornerRadius(configuration.imageCornerRadius)
                    .borderRectangle(
                        configuration.imageBorderColor ?? .clear,
                        configuration.imageCornerRadius,
                        configuration.imageBorderWidth
                    )
                  
                
            } placeholder: {
                Placeholder()
                    .overlay {
                        ProgressView()
                    }
            }
        } else {
            ZStack {
                Placeholder()
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(edge: configuration.placeholderImageSize)
                    .foregroundColor(.pink.opacity(0.5))
            }
        }
    }
}

// MARK: - MKRImageView

private extension MKRImageView {
    
    func Placeholder() -> some View {
        Rectangle()
            .fill(LinearGradient.kingGradient.opacity(0.4))
            .frame(width: configuration.imageSize.width, height: configuration.imageSize.height)
            .cornerRadius(configuration.imageCornerRadius)
            .borderRectangle(
                .pink,
                configuration.imageCornerRadius,
                configuration.placeholderLineWidth
            )
    }
}

// MARK: - Preview

struct MKRImage_Previews: PreviewProvider {
    static var previews: some View {
        MKRImageView(configuration:
                .basic(
                    kind: .custom(
                        url: .mockLoadingUrl,
                        mode: .fill,
                        imageSize: .init(width: 300, height: 200),
                        imageCornerRadius: 20,
                        imageBorderWidth: 2,
                        imageBorderColor: .pink,
                        placeholderLineWidth: 2
                    )
                )
        )
        .preferredColorScheme(.dark)
    }
}
