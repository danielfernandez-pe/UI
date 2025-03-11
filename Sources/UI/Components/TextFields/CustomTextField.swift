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
    let isSecure: Bool
    @Binding var text: String
    @Namespace private var placeholderNamespace
    @FocusState private var focusedField: Bool
    
    // isValid logic
    @Environment(\.isMandatory) var isMandatory
    @Environment(\.validationHandler) var validationHandler
    @State private var isValid = true {
        didSet {
            isValidBinding = isValid
        }
    }
    
    @State private var validationMessage: String = ""
    @Binding private var isValidBinding: Bool
    
    public init(placeholder: String,
                style: Style,
                isSecure: Bool,
                text: Binding<String>,
                isValid isValidBinding: Binding<Bool>? = nil) {
        self.placeholder = placeholder
        self.style = style
        self.isSecure = isSecure
        self._text = text
        self._isValidBinding = isValidBinding ?? .constant(true)
    }

    public var body: some View {
            VStack(alignment: .leading) {
                if !isValid {
                    Text(validationMessage)
                        .font(style.font)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if !text.isEmpty, isValid {
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
                        Group {
                            if isSecure {
                                SecureField("", text: $text)
                            } else {
                                TextField("", text: $text)
                            }
                        }
                        .font(style.font)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .focused($focusedField)
                        .onAppear {
                            validate(text)
                        }
                        .onChange(of: text) { _, newValue in
                            validate(newValue)
                        }
                    
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
    
    private func validate(_ value: String) {
        isValid = true
        
        if isMandatory {
            isValid = !value.isEmpty
            validationMessage = isValid ? "" : "This is a mandatory field"
        }
        
        if isValid {
            guard let validationHandler = validationHandler else { return }
            let validationResult = validationHandler(value)
            
            switch validationResult {
            case .success:
                isValid = true
                validationMessage = ""
            case .failure(let error):
                isValid = false
                validationMessage = error.errorDescription ?? ""
            }
        }
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
            isSecure: false,
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
            isSecure: false,
            text: .constant("")
        )
        .isMandatory()
        
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
            isSecure: true,
            text: .constant("")
        )
    }
}
