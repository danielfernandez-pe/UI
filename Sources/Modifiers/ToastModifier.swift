//
//  ToastModifier.swift
//  UI
//
//  Created by Daniel Fernandez Yopla on 02.04.2025.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var message: String?
    private let status: ToastStatus
    
    public init(message: Binding<String?>, status: ToastStatus) {
        self._message = message
        self.status = status
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            ToastView(message: message ?? "", status: status)
                .opacity(message == nil ? 0 : 1)
                .offset(y: message == nil ? 200 : 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: message)
        }
    }
}

extension View {
    public func toast(_ message: Binding<String?>, status: ToastStatus = .normal) -> some View {
        modifier(ToastModifier(message: message, status: status))
    }
}

#Preview {
    VStack(spacing: 100) {
        Text("We are here")
        
        Text("Another text")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .toast(.constant("There was an  error"))
}
