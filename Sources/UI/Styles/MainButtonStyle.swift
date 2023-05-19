//
//  MainButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 04.01.2023.
//

import SwiftUI

public struct MainButtonStyle: ButtonStyle {
    let textColor: Color
    let backgroundColor: Color

    public init(textColor: Color, backgroundColor: Color) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? backgroundColor.opacity(0.6) : backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
