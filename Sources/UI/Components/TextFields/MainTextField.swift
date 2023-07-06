//
//  MainTextField.swift
//  
//
//  Created by Daniel Yopla on 03.01.2023.
//

import SwiftUI

public struct MainTextField: View {
    private let placeholder: String
    @Binding private var text: String
    @Namespace private var placeholderNamespace
    @State private var contentSize: CGSize = .zero
    
    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
            VStack(alignment: .leading) {
                if !text.isEmpty {
                    Text(placeholder)
                        .font(.caption)
                        .frame(width: contentSize.width * 0.8, alignment: .leading)
                        .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                }
                
                ZStack(alignment: .leading) {
                    TextField("", text: $text)
                        .font(.body)
                        .frame(maxWidth: .infinity)
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .font(.body)
                            .frame(width: contentSize.width * 0.8, alignment: .leading)
                            .matchedGeometryEffect(id: "placeholder", in: placeholderNamespace)
                            .allowsHitTesting(false)
                    }
                }
                .readSize(onChange: { contentSize = $0 })
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 2)
                }
        }
        .animation(.easeInOut, value: text)
    }
}

struct MainTextFieldPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTextField(placeholder: "", text: .constant("Some text"))
                .previewLayout(.sizeThatFits)
            
            MainTextField(placeholder: "Name", text: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
}
