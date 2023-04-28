//
//  File.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation

struct Spacing {
    static let xSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let xLarge: CGFloat = 32
}

public extension CGFloat {
    static var xSmall: CGFloat {
        Spacing.xSmall
    }

    static var small: CGFloat {
        Spacing.small
    }

    static var medium: CGFloat {
        Spacing.medium
    }

    static var large: CGFloat {
        Spacing.large
    }

    static var xLarge: CGFloat {
        Spacing.xLarge
    }
}
