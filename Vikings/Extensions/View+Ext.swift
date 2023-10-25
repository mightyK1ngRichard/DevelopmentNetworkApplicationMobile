//
//  View+Ext.swift
//  Vikings
//
//  Created by Дмитрий Пермяков on 17.09.2023.
//

import SwiftUI

extension View {
    
    func frame(edge size: CGFloat) -> some View {
        self
            .frame(width: size, height: size)
    }
    
    func borderRectangle<S: ShapeStyle>(
        _ color: S,
        _ corner: CGFloat,
        _ lineWidth: CGFloat
    ) -> some View {
        self
            .overlay {
                RoundedRectangle(cornerRadius: corner)
                    .stroke(lineWidth: lineWidth)
                    .fill(color)
            }
    }
    
    var leadingAlignment: some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    func offset(
        coordingateSpace: CoordinateSpace,
        completion: @escaping (CGFloat) -> Void
    ) -> some View {
        self.overlay {
            GeometryReader { proxy in
                let minY = proxy.frame(in: coordingateSpace).minY
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }
}
