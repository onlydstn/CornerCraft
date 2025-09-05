//
//  CornerCraftShape.swift
//  CornerCraft
//
//  Created by Dustin Nuzzo on 05.09.25.
//

import SwiftUI

// MARK: - CornerCraftShape

/// A custom Shape that allows selective corner rounding based on UIRectCorner specification
public struct CornerCraftShape: Shape {
    public var corners: UIRectCorner
    public var radius: CGFloat
    
    public var animatableData: CGFloat {
        get { radius }
        set { radius = newValue }
    }
    
    public init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}