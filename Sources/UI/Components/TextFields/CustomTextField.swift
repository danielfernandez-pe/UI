//
//  CustomTextField.swift
//
//
//  Created by Daniel Yopla on 03.01.2023.
//

import SwiftUI

public struct CustomTextField: View {
    let placeholder: String
    let style: TextFieldStyle
    @Binding var text: String
    @Namespace private var placeholderNamespace
    @FocusState private var focusedField: Bool

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
    public struct TextFieldStyle {
        let borderColor: Color
        let focusedBorderColor: Color
        let placeholderColor: Color
        let icon: Image?
        let font: Font
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
