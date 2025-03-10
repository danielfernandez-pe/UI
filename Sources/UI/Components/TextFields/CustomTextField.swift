//
//  CustomTextField.swift
//
//
//  Created by Daniel Yopla on 03.01.2023.
//

import SwiftUI

public struct CustomTextField: View {
    let placeholder: String
    let style: Style
    @Binding var text: String
    @Namespace private var placeholderNamespace
    @FocusState private var focusedField: Bool
    
    public init(placeholder: String,
                style: Style,
                text: Binding<String>) {
        self.placeholder = placeholder
        self.style = style
        self._text = text
    }

    public var body: some View {
            VStack(alignment: .leading) {
                if !text.isEmpty {
                    Text(placeholder)
                        .font(style.font)
                        .foregroundStyle(style.placeholderColor)
                        .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack(spacing: .small) {
                    if let icon = style.icon, let iconColor = style.iconColor {
                        icon
                            .foregroundStyle(iconColor)
                    }
                    
                    ZStack(alignment: .leading) {
                        TextField("", text: $text)
                            .font(style.font)
                            .frame(maxWidth: .infinity, minHeight: 36)
                            .focused($focusedField)
                    
                        if text.isEmpty {
                            Text(placeholder)
                                .font(style.font)
                                .foregroundStyle(style.placeholderColor)
                                .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                                .allowsHitTesting(false)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            focusedField ? style.focusedBorderColor : style.borderColor,
                            lineWidth: focusedField ? 2 : 1
                        )
                }
        }
        .animation(.easeInOut, value: text)
    }
}

extension CustomTextField {
    public struct Style {
        let borderColor: Color
        let focusedBorderColor: Color
        let placeholderColor: Color
        let icon: Image?
        let iconColor: Color?
        let font: Font
        
        public init(borderColor: Color,
                    focusedBorderColor: Color,
                    placeholderColor: Color,
                    font: Font,
                    icon: Image? = nil,
                    iconColor: Color? = nil) {
            self.borderColor = borderColor
            self.focusedBorderColor = focusedBorderColor
            self.placeholderColor = placeholderColor
            self.font = font
            self.icon = icon
            self.iconColor = iconColor
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        CustomTextField(
            placeholder: "Name",
            style: .init(
                borderColor: .gray,
                focusedBorderColor: .red,
                placeholderColor: .gray,
                font: .body
            ),
            text: .constant("Some text")
        )
        
        CustomTextField(
            placeholder: "Email",
            style: .init(
                borderColor: .gray,
                focusedBorderColor: .red,
                placeholderColor: .gray,
                font: .body,
                icon: Image(systemName: "person.fill")
            ),
            text: .constant("")
        )
        
        CustomTextField(
            placeholder: "Password",
            style: .init(
                borderColor: .gray,
                focusedBorderColor: .red,
                placeholderColor: .gray,
                font: .body,
                icon: Image(systemName: "lock.fill"),
                iconColor: .red
            ),
            text: .constant("")
        )
    }
}
