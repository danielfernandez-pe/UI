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
                text: String) {
        self.placeholder = placeholder
        self.style = style
        self.text = text
    }

    public var body: some View {
            VStack(alignment: .leading) {
                if !text.isEmpty {
                    Text(placeholder)
                        .font(style.font)
                        .foregroundStyle(style.placeholderColor)
                        .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                }
                
                HStack(spacing: .small) {
                    if let icon = style.icon {
                        icon
                    }
                    
                    ZStack(alignment: .leading) {
                        TextField("", text: $text)
                            .font(style.font)
                            .frame(maxWidth: .infinity, minHeight: 36)
                            .focused($focusedField)
                    
                        if text.isEmpty {
                            Text(placeholder)
                                .font(.body)
                                .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                                .allowsHitTesting(false)
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
        let font: Font
        
        public init(borderColor: Color, focusedBorderColor: Color, placeholderColor: Color, icon: Image?, font: Font) {
            self.borderColor = borderColor
            self.focusedBorderColor = focusedBorderColor
            self.placeholderColor = placeholderColor
            self.icon = icon
            self.font = font
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
                icon: nil,
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
                icon: Image(systemName: "person.fill"),
                font: .body
            ),
            text: .constant("")
        )
    }
}
