//
//  View+.swift
//  
//
//  Created by Daniel Yopla on 04.01.2023.
//

import SwiftUI

extension View {
    public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { metrics in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: metrics.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    public func frame(size: CGSize) -> some View {
        self
            .frame(width: size.width, height: size.height)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}

    static var defaultValue: CGSize = .zero
}
