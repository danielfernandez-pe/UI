//
//  MainButtonStyle.swift
//  
//
//  Created by Daniel Yopla on 04.01.2023.
//

import SwiftUI

public struct MainButtonStyle<Content: View>: ButtonStyle {
    public struct Style {
        let textColor: Color
        let backgroundColor: Color
        let pressedBackgroundColor: Color
        let disabledBackgroundColor: Color
        let uiFont: UIFont
        let cornerRadius: CGFloat
        let shouldScaleWhenPressed: Bool
        let isDark: Bool
        let icon: (() -> Content)?

        public init(textColor: Color = .white,
                    backgroundColor: Color = .blue,
                    pressedBackgroundColor: Color = Color.blue.opacity(0.6),
                    disabledBackgroundColor: Color = Color.blue.opacity(0.3),
                    uiFont: UIFont = .systemFont(ofSize: 16),
                    cornerRadius: CGFloat = 16,
                    shouldScaleWhenPressed: Bool = true,
                    isDark: Bool = false,
                    icon: (() -> Content)?) {
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.pressedBackgroundColor = pressedBackgroundColor
            self.disabledBackgroundColor = disabledBackgroundColor
            self.uiFont = uiFont
            self.cornerRadius = cornerRadius
            self.shouldScaleWhenPressed = shouldScaleWhenPressed
            self.isDark = isDark
            self.icon = icon
        }
    }

    private let style: Style
    @Environment(\.isEnabled) var isEnabled

    public init(style: Style) {
        self.style = style
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(style.uiFont as CTFont))
            .padding()
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(
                Group {
                    if !isEnabled {
                        style.disabledBackgroundColor
                    } else if configuration.isPressed {
                        style.pressedBackgroundColor
                    } else {
                        style.backgroundColor
                    }
                }
            )
            .foregroundColor(style.textColor)
            .cornerRadius(style.cornerRadius)
            .scaleEffect(shouldScale(configuration: configuration) ? 0.98 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .if(style.isDark) { $0.environment(\.colorScheme, .dark) }
            .overlay(alignment: .trailing) {
                style.icon?()
                    .padding(.trailing, .small)
            }
    }

    private func shouldScale(configuration: Configuration) -> Bool {
        if style.shouldScaleWhenPressed {
            return configuration.isPressed
        }

        return false
    }
}
