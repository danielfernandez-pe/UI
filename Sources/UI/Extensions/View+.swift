//
//  View+.swift
//  
//
//  Created by Daniel Yopla on 04.01.2023.
//

import SwiftUI

extension View {
    public func addShadow(color: Color) -> some View {
        self
            .shadow(color: color, radius: 16, x: 0, y: 4)
    }
    
    public func frame(size: CGSize) -> some View {
        self
            .frame(width: size.width, height: size.height)
    }

    @ViewBuilder public func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
