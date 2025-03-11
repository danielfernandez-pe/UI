//
//  OnValidate.swift
//  UI
//
//  Created by Daniel Fernandez Yopla on 11.03.2025.
//

import SwiftUI

public enum ValidationError: Error, LocalizedError {
    case isNotEmail
    
    public var errorDescription: String? {
        switch self {
        case .isNotEmail: return "Not a valid email"
        }
    }
}

public extension View {
    func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
        environment(\.validationHandler, validationHandler)
    }
}

struct TextInputFieldValidationHandler: @preconcurrency EnvironmentKey {
    @MainActor static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

extension EnvironmentValues {
    var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
        get {
            self[TextInputFieldValidationHandler.self]
        } set {
            self[TextInputFieldValidationHandler.self] = newValue
        }
    }
}
