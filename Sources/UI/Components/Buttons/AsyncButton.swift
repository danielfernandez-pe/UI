//
//  AsyncButton.swift
//
//
//  Created by Daniel Yopla on 28.04.2023.
//

// https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/
import SwiftUI

public struct AsyncButton<Label: View>: View {
    var action: () async -> Void

    @ViewBuilder var label: () -> Label
    @State private var showProgressView = false

    public init(action: @escaping () async -> Void, label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(
            action: {
                Task {
                    showProgressView = true
                    await action()
                    showProgressView = false
                }
            },
            label: {
                ZStack {
                    // We hide the label by setting its opacity
                    // to zero, since we don't want the button's
                    // size to change while its task is performed:
                    label().opacity(showProgressView ? 0 : 1)

                    if showProgressView {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(showProgressView)
    }
}

public extension AsyncButton where Label == Text {
    init(_ label: String,
         action: @escaping () async -> Void) {
        self.init(action: action) {
            Text(label)
        }
    }
}

public extension AsyncButton where Label == Image {
    init(systemImageName: String,
         action: @escaping () async -> Void) {
        self.init(action: action) {
            Image(systemName: systemImageName)
        }
    }
}
