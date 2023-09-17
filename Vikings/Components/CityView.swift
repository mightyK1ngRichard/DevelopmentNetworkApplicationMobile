//
//  CityView.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 17.09.2023.
//

import SwiftUI

struct CityView: View {
    let imageConfiguration: MKRImageView.Configuration = .basic(
        kind: .custom(
            url: .mockLoadingUrl,
            mode: .fill,
            imageSize: .imageSize,
            imageCornerRadius: .imageCornerRadius,
            imageBorderWidth: .imageBorderWidth,
            imageBorderColor: .pink,
            placeholderLineWidth: .placeholderLineWidth
        )
    )
    
    var body: some View {
        MKRImageView(configuration: imageConfiguration)
    }
}

// MARK: - Constants

private extension CGSize {
    
    static let imageSize = CGSize(width: 300, height: 200)
}

private extension CGFloat {
    
    static let imageCornerRadius: CGFloat = 20
    static let imageBorderWidth: CGFloat = 2
    static let placeholderLineWidth: CGFloat = 2
}

// MARK: - Priview

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
