//
//  ToastView.swift
//  UI
//
//  Created by Daniel Fernandez Yopla on 02.04.2025.
//

import SwiftUI

public enum ToastStatus {
    case success
    case normal
    case error
    
    var imageName: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .normal:
            return "exclamationmark.circle.fill"
        case .error:
            return "exclamationmark.triangle.fill"
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .success:
            return .green
        case .normal:
            return .orange
        case .error:
            return .red
        }
    }
}

struct ToastView: View {
    private let message: String
    private let status: ToastStatus
    
    init(message: String, status: ToastStatus) {
        self.message = message
        self.status = status
    }
    
    var body: some View {
        HStack(spacing: .medium) {
            Image(systemName: status.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(status.foregroundColor)
            
            Text(message)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
        }
        .padding(.large)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        }
        .padding(.horizontal, .large)
        .addShadow()
    }
}

#Preview {
    VStack(spacing: .large) {
        ToastView(message: "Error with credentials", status: .success)
        
        ToastView(message: "Error with credentials", status: .normal)
        
        ToastView(message: "Error with credentials", status: .error)
    }
}
