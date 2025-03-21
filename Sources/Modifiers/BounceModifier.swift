//
//  BounceModifier.swift
//  
//
//  Created by Daniel Yopla on 26.05.2023.
//

import SwiftUI

// Got it from https://stackoverflow.com/a/73766836
enum BounceHeight {
    case up40
    case up10
    case up5
    case base

    var associatedOffset: Double {
        switch self {
        case .up40:
            return -40
        case .up10:
            return -10
        case .up5:
            return -5
        case .base:
            return 0
        }
    }
}

struct BounceModifier: ViewModifier {
    let shouldBounce: Bool

    @State private var bounceHeight: BounceHeight?

    func body(content: Content) -> some View {
        content
            .offset(y: bounceHeight?.associatedOffset ?? 0)
            .onAppear {
                if shouldBounce {
                    startBounceAnimation()
                }
            }
    }

    private func startBounceAnimation() {
        withAnimation(Animation.easeOut(duration: 0.3).delay(0)) {
            bounceHeight = .up40
        }
        withAnimation(Animation.easeInOut(duration: 0.04).delay(0)) {
            bounceHeight = .up40
        }
        withAnimation(Animation.easeIn(duration: 0.3).delay(0.34)) {
            bounceHeight = .base
        }
        withAnimation(Animation.easeOut(duration: 0.2).delay(0.64)) {
            bounceHeight = .up10
        }
        withAnimation(Animation.easeIn(duration: 0.2).delay(0.84)) {
            bounceHeight = .base
        }
        withAnimation(Animation.easeOut(duration: 0.1).delay(1.04)) {
            bounceHeight = .up5
        }
        withAnimation(Animation.easeIn(duration: 0.1).delay(1.14)) {
            bounceHeight = .none
        }
    }
}

extension View {
    public func bounce(_ shouldBounce: Bool = true) -> some View {
        modifier(BounceModifier(shouldBounce: shouldBounce))
    }
}

struct JumpModifierPreviews: PreviewProvider {
    static var previews: some View {
        Button("Make me jump", action: {})
            .buttonStyle(.bordered)
            .bounce(true)
    }
}
