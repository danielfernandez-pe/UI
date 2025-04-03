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
    @State private var offset = CGSize.zero
    @State private var timerTask: Task<Void, Error>? = nil
    
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
                .offset(y: offset.height > 0 ? offset.height : 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            if offset.height > 50 {
                                timerTask?.cancel()
                                timerTask = nil
                                message = nil
                            }
                            
                            offset = .zero
                        }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: offset)
                .onChange(of: message) { _, _ in
                    guard message != nil else {
                        return
                    }
                    timerTask?.cancel()
                    timerTask = nil
                    
                    timerTask = Task {
                        try? await Task.sleep(for: .seconds(3))
                        
                        if !Task.isCancelled, self.message != nil {
                            await MainActor.run {
                                self.message = nil
                            }
                        }
                    }
                }
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
