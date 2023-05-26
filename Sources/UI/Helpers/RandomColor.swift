//
//  RandomColor.swift
//  
//
//  Created by Daniel Yopla on 21.05.2023.
//

import SwiftUI

// https://gist.github.com/steipete/579edd8bd8b25dc8a89b546b54d9222f
public extension ShapeStyle where Self == Color {
    static var debug: Color {
    #if DEBUG
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    #else
        return Color(.clear)
    #endif
    }
}
