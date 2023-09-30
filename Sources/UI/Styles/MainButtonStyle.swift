//
//  MainButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 04.01.2023.
//

import SwiftUI

public struct MainButtonStyle: ButtonStyle {
    public struct Style {
        let textColor: Color
        let backgroundColor: Color
        let pressedBackgroundColor: Color
        let uiFont: UIFont
        let cornerRadius: CGFloat
        let shouldScaleWhenPressed: Bool
        let isDark: Bool

        public init(textColor: Color = .white,
                    backgroundColor: Color = .blue,
                    pressedBackgroundColor: Color = Color.blue.opacity(0.6),
                    uiFont: UIFont = .systemFont(ofSize: 16),
                    cornerRadius: CGFloat = 16,
                    shouldScaleWhenPressed: Bool = true,
                    isDark: Bool = false) {
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.pressedBackgroundColor = pressedBackgroundColor
            self.uiFont = uiFont
            self.cornerRadius = cornerRadius
            self.shouldScaleWhenPressed = shouldScaleWhenPressed
            self.isDark = isDark
        }
    }

    private let style: Style

    public init(style: Style) {
        self.style = style
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(style.uiFont as CTFont))
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? style.pressedBackgroundColor : style.backgroundColor)
            .foregroundColor(style.textColor)
            .cornerRadius(style.cornerRadius)
            .scaleEffect(shouldScale(configuration: configuration) ? 0.98 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .if(style.isDark) { $0.environment(\.colorScheme, .dark) }
    }

    private func shouldScale(configuration: Configuration) -> Bool {
        if style.shouldScaleWhenPressed {
            return configuration.isPressed
        }

        return false
    }
}
