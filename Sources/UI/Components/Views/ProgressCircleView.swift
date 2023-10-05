//
//  ProgressCircleView.swift
//
//
//  Created by Daniel Yopla on 05.10.2023.
//

import SwiftUI

public struct ProgressCircleView: View {
    private let progress: CGFloat
    private let color: Color

    public init(progress: CGFloat, color: Color) {
        self.progress = progress
        self.color = color
    }

    public var body: some View {
        Circle()
            .trim(from: 0, to: progress / 100)
            .stroke(color, style: .init(lineWidth: 10, lineCap: .round))
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    ProgressCircleView(progress: 70, color: .blue)
        .frame(size: .init(width: 80, height: 80))
}
