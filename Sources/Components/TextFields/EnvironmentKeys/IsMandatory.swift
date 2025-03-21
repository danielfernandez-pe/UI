//
//  IsMandatory.swift
//  UI
//
//  Created by Daniel Fernandez Yopla on 11.03.2025.
//

import SwiftUI

public extension View {
    func isMandatory(_ value: Bool = true) -> some View {
        environment(\.isMandatory, value)
    }
}

private struct TextInputFieldMandatory: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isMandatory: Bool {
        get { self[TextInputFieldMandatory.self] }
        set { self[TextInputFieldMandatory.self] = newValue }
    }
}
