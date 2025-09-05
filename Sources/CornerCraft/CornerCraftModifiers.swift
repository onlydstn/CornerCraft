//
//  CornerCraftModifiers.swift
//  CornerCraft
//
//  Created by Dustin Nuzzo on 05.09.25.
//

import SwiftUI

// MARK: - CornerCraftAnimationType

/// Animation types available for CornerCraft modifiers
public enum CornerCraftAnimationType {
    case none
    case easeInOut(duration: Double = 0.3)
    case spring(duration: Double = 0.6, bounce: Double = 0.0)
    case linear(duration: Double = 0.3)
    case easeIn(duration: Double = 0.3)
    case easeOut(duration: Double = 0.3)
    
    /// Convert to SwiftUI Animation
    var swiftUIAnimation: Animation? {
        switch self {
        case .none:
            return nil
        case .easeInOut(let duration):
            return .easeInOut(duration: duration)
        case .spring(let duration, let bounce):
            return .spring(duration: duration, bounce: bounce)
        case .linear(let duration):
            return .linear(duration: duration)
        case .easeIn(let duration):
            return .easeIn(duration: duration)
        case .easeOut(let duration):
            return .easeOut(duration: duration)
        }
    }
}

// MARK: - CornerCraftBorderModifier

/// Internal ViewModifier for applying corner craft with optional border and animation
private struct CornerCraftBorderModifier: ViewModifier {
    let corners: UIRectCorner
    let radius: CGFloat
    let borderColor: Color?
    let borderWidth: CGFloat
    let animationType: CornerCraftAnimationType
    
    func body(content: Content) -> some View {
        let modifiedContent = content
            .clipShape(CornerCraftShape(corners: corners, radius: radius))
            .overlay(
                CornerCraftShape(corners: corners, radius: radius)
                    .stroke(borderColor ?? Color.clear, lineWidth: borderWidth)
            )
        
        if let animation = animationType.swiftUIAnimation {
            return AnyView(modifiedContent.animation(animation, value: radius))
        } else {
            return AnyView(modifiedContent)
        }
    }
}

// MARK: - View Extensions

public extension View {
    /// Apply corner craft to the view with specified corners and radius
    /// - Parameters:
    ///   - corners: The corners to round (UIRectCorner)
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with corner craft applied
    func cornerCraft(
        _ corners: UIRectCorner,
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        modifier(CornerCraftBorderModifier(
            corners: corners,
            radius: radius,
            borderColor: borderColor,
            borderWidth: borderWidth,
            animationType: animationType
        ))
    }
    
    // MARK: - Predefined Corner Presets
    
    /// Round only the top-left corner
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with top-left corner rounded
    func topLeftRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft(.topLeft, radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round only the top-right corner
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with top-right corner rounded
    func topRightRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft(.topRight, radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round only the bottom-left corner
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with bottom-left corner rounded
    func bottomLeftRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft(.bottomLeft, radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round only the bottom-right corner
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with bottom-right corner rounded
    func bottomRightRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft(.bottomRight, radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round both top corners (top-left and top-right)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with top corners rounded
    func topRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.topLeft, .topRight], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round both bottom corners (bottom-left and bottom-right)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with bottom corners rounded
    func bottomRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.bottomLeft, .bottomRight], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round all corners
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with all corners rounded
    func allRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft(.allCorners, radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Remove all corner rounding (rectangular shape)
    /// - Parameters:
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with no corner rounding
    func noneRounded(
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([], radius: 0, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    // MARK: - Diagonal Corner Presets
    
    /// Round diagonal corners (top-left and bottom-right)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with diagonal corners rounded
    func topLeftBottomRightRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.topLeft, .bottomRight], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round diagonal corners (top-right and bottom-left)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with diagonal corners rounded
    func topRightBottomLeftRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.topRight, .bottomLeft], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    // MARK: - Side Corner Presets
    
    /// Round both left corners (top-left and bottom-left)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with left corners rounded
    func leftRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.topLeft, .bottomLeft], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
    
    /// Round both right corners (top-right and bottom-right)
    /// - Parameters:
    ///   - radius: The radius for rounding
    ///   - borderColor: Optional border color
    ///   - borderWidth: Border width (default: 0)
    ///   - animationType: Animation type for radius changes (default: .none)
    /// - Returns: Modified view with right corners rounded
    func rightRounded(
        radius: CGFloat,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        animationType: CornerCraftAnimationType = .none
    ) -> some View {
        cornerCraft([.topRight, .bottomRight], radius: radius, borderColor: borderColor, borderWidth: borderWidth, animationType: animationType)
    }
}