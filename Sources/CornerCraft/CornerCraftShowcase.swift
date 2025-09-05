//
//  CornerCraftShowcase.swift
//  CornerCraft
//
//  Created by Dustin Nuzzo on 05.09.25.
//

import SwiftUI

public enum ShowcaseSection: String, CaseIterable {
    case overview = "Overview"
    case presets = "Presets"
    case animations = "Animations"
    case styling = "Styling"
    case examples = "Examples"
}

public struct CornerCraftShowcase: View {
    @State private var selectedSection: ShowcaseSection = .overview
    @State private var selectedRadius: CGFloat = 20
    @State private var selectedBorderWidth: CGFloat = 2
    @State private var selectedBorderColor: Color = .blue
    @State private var selectedCorners: UIRectCorner = .allCorners
    @State private var selectedAnimation: CornerCraftAnimationType = .spring(duration: 0.6, bounce: 0.3)
    @State private var isAnimating: Bool = false
    @State private var animationDemoRadius: CGFloat = 20
    
    public init() {}
    
    public var body: some View {
            VStack(spacing: 0) {
                segmentedPicker
                
                ScrollView {
                    VStack(spacing: 40) {
                        currentSectionView
                    }
                    .padding()
                    .padding(.bottom, 20)
                }
                .background(
                    LinearGradient(
                        colors: [
                            Color(.systemBackground),
                            Color(.systemGray6).opacity(0.3)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
    
    private var segmentedPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ShowcaseSection.allCases, id: \.self) { section in
                    Button(section.rawValue) {
                        selectedSection = section
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        selectedSection == section ? 
                        Color.blue : Color(.systemGray5)
                    )
                    .foregroundColor(
                        selectedSection == section ? .white : .primary
                    )
                    .allRounded(radius: 12)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .scaleEffect(selectedSection == section ? 1.05 : 1.0)
                    .shadow(
                        color: selectedSection == section ? .blue.opacity(0.3) : .clear,
                        radius: selectedSection == section ? 4 : 0,
                        x: 0, y: 2
                    )
                    .animation(.spring(duration: 0.4, bounce: 0.3), value: selectedSection == section)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(.systemGray6).opacity(0.5))
    }
    
    @ViewBuilder
    private var currentSectionView: some View {
        switch selectedSection {
        case .overview:
            VStack(spacing: 40) {
                headerSection
                coreAPISection
            }
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
        case .presets:
            presetModifiersSection
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        case .animations:
            animationTypesSection
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        case .styling:
            borderStylingSection
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        case .examples:
            VStack(spacing: 40) {
                realWorldExamplesSection
                footerSection
            }
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                LinearGradient(
                    colors: [.blue, .purple, .pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 140)
                
                VStack(spacing: 8) {
                    Text("🎨")
                        .font(.system(size: 40))
                    
                    Text("CornerCraft")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Selective Corner Rounding for SwiftUI")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .cornerCraft(
                selectedCorners,
                radius: animationDemoRadius,
                borderColor: selectedBorderColor,
                borderWidth: selectedBorderWidth,
                animationType: selectedAnimation
            )
            .shadow(color: .blue.opacity(0.4), radius: 15, x: 0, y: 8)
            
            HStack(spacing: 20) {
                featureBadge("12 Presets", .blue)
                featureBadge("6 Animations", .purple) 
                featureBadge("Borders", .pink)
            }
        }
    }
    
    private func featureBadge(_ text: String, _ color: Color) -> some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .allRounded(radius: 12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
    }
    
    // MARK: - Core API Section
    private var coreAPISection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Interactive Demo")
            
            VStack(spacing: 16) {
                VStack(spacing: 12) {
                    cornerSelectionView
                    radiusSlider
                    borderWidthSlider
                    borderColorPicker
                    animationSelector
                }
                .padding()
                .background(Color(.systemGray6))
                .allRounded(radius: 16)
            }
        }
    }
    
    private var cornerSelectionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selected Corners")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                cornerButton("All Corners", .allCorners)
                cornerButton("Top", [.topLeft, .topRight])
                cornerButton("Bottom", [.bottomLeft, .bottomRight])
                cornerButton("Left", [.topLeft, .bottomLeft])
                cornerButton("Right", [.topRight, .bottomRight])
                cornerButton("Top Left", .topLeft)
                cornerButton("Top Right", .topRight)
                cornerButton("Bottom Left", .bottomLeft)
                cornerButton("Bottom Right", .bottomRight)
                cornerButton("Diagonal \\", [.topLeft, .bottomRight])
                cornerButton("Diagonal /", [.topRight, .bottomLeft])
                cornerButton("None", [])
            }
        }
    }
    
    private func cornerButton(_ title: String, _ corners: UIRectCorner) -> some View {
        Button(title) {
            withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                selectedCorners = corners
            }
            // Ensure demo radius stays in sync
            animationDemoRadius = selectedRadius
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(selectedCorners == corners ? Color.blue : Color(.systemGray5))
        .foregroundColor(selectedCorners == corners ? .white : .primary)
        .allRounded(radius: 8)
        .font(.caption)
        .fontWeight(.medium)
        .scaleEffect(selectedCorners == corners ? 1.05 : 1.0)
        .animation(.spring(duration: 0.3, bounce: 0.4), value: selectedCorners == corners)
    }
    
    private var radiusSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Radius: \(Int(selectedRadius))")
                .font(.headline)
            Slider(value: $selectedRadius, in: 0...50)
                .accentColor(.blue)
                .onChange(of: selectedRadius) { newValue in
                    animationDemoRadius = newValue
                }
        }
    }
    
    private var borderWidthSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Border Width: \(Int(selectedBorderWidth))")
                .font(.headline)
            Slider(value: $selectedBorderWidth, in: 0...10)
                .accentColor(.blue)
        }
    }
    
    private var borderColorPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Border Color")
                .font(.headline)
            
            HStack(spacing: 12) {
                colorCircle(.blue)
                colorCircle(.red)
                colorCircle(.green)
                colorCircle(.purple)
                colorCircle(.orange)
                colorCircle(.pink)
                colorCircle(.black)
                colorCircle(.gray)
            }
        }
    }
    
    private func colorCircle(_ color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: 30, height: 30)
            .overlay(
                Circle()
                    .stroke(Color.primary, lineWidth: selectedBorderColor == color ? 3 : 0)
            )
            .scaleEffect(selectedBorderColor == color ? 1.2 : 1.0)
            .animation(.spring(duration: 0.3, bounce: 0.4), value: selectedBorderColor == color)
            .onTapGesture {
                withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                    selectedBorderColor = color
                }
                // Ensure demo radius stays in sync
                animationDemoRadius = selectedRadius
            }
    }
    
    private var animationSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Animation Type")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                animationButton("None", .none)
                animationButton("Ease In Out", .easeInOut())
                animationButton("Spring", .spring())
                animationButton("Linear", .linear())
                animationButton("Ease In", .easeIn())
                animationButton("Ease Out", .easeOut())
            }
        }
    }
    
    private func animationButton(_ title: String, _ animation: CornerCraftAnimationType) -> some View {
        Button(title) {
            withAnimation(.spring(duration: 0.5, bounce: 0.2)) {
                selectedAnimation = animation
            }
            
            // Trigger a demo animation to show the effect immediately
            let currentRadius = animationDemoRadius
            animationDemoRadius = currentRadius == selectedRadius ? selectedRadius + 15 : selectedRadius
            
            // Reset after a delay to show the animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animationDemoRadius = selectedRadius
            }
        }
        .frame(maxWidth: .infinity, minHeight: 32)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(animationMatches(animation) ? Color.blue : Color(.systemGray5))
        .foregroundColor(animationMatches(animation) ? .white : .primary)
        .allRounded(radius: 6)
        .font(.caption2)
        .fontWeight(.medium)
        .scaleEffect(animationMatches(animation) ? 1.05 : 1.0)
        .animation(.spring(duration: 0.3, bounce: 0.4), value: animationMatches(animation))
    }
    
    private func animationMatches(_ animation: CornerCraftAnimationType) -> Bool {
        switch (selectedAnimation, animation) {
        case (.none, .none): return true
        case (.easeInOut, .easeInOut): return true
        case (.spring, .spring): return true
        case (.linear, .linear): return true
        case (.easeIn, .easeIn): return true
        case (.easeOut, .easeOut): return true
        default: return false
        }
    }
    
    // MARK: - Preset Modifiers Section
    private var presetModifiersSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Preset Modifiers")
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Individual corners
                presetModifierCard("topLeftRounded", color: .blue) {
                    Rectangle()
                        .fill(Color.blue.gradient)
                        .frame(height: 80)
                        .topLeftRounded(radius: 20)
                }
                
                presetModifierCard("topRightRounded", color: .green) {
                    Rectangle()
                        .fill(Color.green.gradient)
                        .frame(height: 80)
                        .topRightRounded(radius: 20)
                }
                
                presetModifierCard("bottomLeftRounded", color: .orange) {
                    Rectangle()
                        .fill(Color.orange.gradient)
                        .frame(height: 80)
                        .bottomLeftRounded(radius: 20)
                }
                
                presetModifierCard("bottomRightRounded", color: .pink) {
                    Rectangle()
                        .fill(Color.pink.gradient)
                        .frame(height: 80)
                        .bottomRightRounded(radius: 20)
                }
                
                // Side combinations
                presetModifierCard("topRounded", color: .purple) {
                    Rectangle()
                        .fill(Color.purple.gradient)
                        .frame(height: 80)
                        .topRounded(radius: 20)
                }
                
                presetModifierCard("bottomRounded", color: .indigo) {
                    Rectangle()
                        .fill(Color.indigo.gradient)
                        .frame(height: 80)
                        .bottomRounded(radius: 20)
                }
                
                presetModifierCard("leftRounded", color: .cyan) {
                    Rectangle()
                        .fill(Color.cyan.gradient)
                        .frame(height: 80)
                        .leftRounded(radius: 20)
                }
                
                presetModifierCard("rightRounded", color: .mint) {
                    Rectangle()
                        .fill(Color.mint.gradient)
                        .frame(height: 80)
                        .rightRounded(radius: 20)
                }
                
                // Diagonal combinations
                presetModifierCard("topLeftBottomRightRounded", color: .teal) {
                    Rectangle()
                        .fill(Color.teal.gradient)
                        .frame(height: 80)
                        .topLeftBottomRightRounded(radius: 20)
                }
                
                presetModifierCard("topRightBottomLeftRounded", color: .brown) {
                    Rectangle()
                        .fill(Color.brown.gradient)
                        .frame(height: 80)
                        .topRightBottomLeftRounded(radius: 20)
                }
                
                // All and none
                presetModifierCard("allRounded", color: .red) {
                    Rectangle()
                        .fill(Color.red.gradient)
                        .frame(height: 80)
                        .allRounded(radius: 20)
                }
                
                presetModifierCard("noneRounded", color: .gray) {
                    Rectangle()
                        .fill(Color.gray.gradient)
                        .frame(height: 80)
                        .noneRounded()
                }
            }
        }
    }
    
    private func presetModifierCard<Content: View>(_ title: String, color: Color, @ViewBuilder content: @escaping () -> Content) -> some View {
        VStack(spacing: 12) {
            content()
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(color)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.systemGray6))
        .allRounded(radius: 12)
    }
    
    // MARK: - Animation Types Section
    private var animationTypesSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Animation Types")
            
            VStack(spacing: 16) {
                HStack {
                    Button(isAnimating ? "Stop Animation" : "Start Animation") {
                        isAnimating.toggle()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .allRounded(radius: 8)
                    
                    Spacer()
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    animationDemo("None", .none, .cyan)
                    animationDemo("Ease In Out", .easeInOut(), .mint)
                    animationDemo("Spring", .spring(duration: 0.8, bounce: 0.4), .teal)
                    animationDemo("Linear", .linear(), .blue)
                    animationDemo("Ease In", .easeIn(), .indigo)
                    animationDemo("Ease Out", .easeOut(), .purple)
                }
            }
        }
    }
    
    private func animationDemo(_ title: String, _ animationType: CornerCraftAnimationType, _ color: Color) -> some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(color.gradient)
                .frame(height: 80)
                .allRounded(
                    radius: isAnimating ? 40 : 8,
                    animationType: animationType
                )
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(color)
        }
        .padding()
        .background(Color(.systemGray6))
        .allRounded(radius: 12)
    }
    
    // MARK: - Border & Styling Section
    private var borderStylingSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Border & Styling")
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                borderExample("Solid Border", .blue, 3)
                borderExample("Thin Border", .green, 1)
                borderExample("Thick Border", .red, 6)
                borderExample("No Border", .clear, 0)
            }
        }
    }
    
    private func borderExample(_ title: String, _ borderColor: Color, _ borderWidth: CGFloat) -> some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(LinearGradient(colors: [.orange.opacity(0.3), .pink.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 80)
                .allRounded(radius: 16, borderColor: borderColor, borderWidth: borderWidth)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemGray6))
        .allRounded(radius: 12)
    }
    
    // MARK: - Real-World Examples Section
    private var realWorldExamplesSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Real-World Examples")
            
            VStack(spacing: 24) {
                cardExample
                buttonExample
                formElementExample
                navigationExample
            }
        }
    }
    
    private var cardExample: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Card Component")
                .font(.headline)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Product Card")
                    .font(.headline)
                
                Text("A beautiful product with selective corner rounding that makes it stand out from other cards.")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("$29.99")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    
                    Spacer()
                    
                    Button("Add to Cart") {}
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .allRounded(radius: 8)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .topRounded(radius: 20, borderColor: .gray.opacity(0.2), borderWidth: 1)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
    
    private var buttonExample: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Button Styles")
                .font(.headline)
                .foregroundColor(.green)
            
            HStack(spacing: 12) {
                Button("Primary") {}
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .allRounded(radius: 12)
                
                Button("Secondary") {}
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.clear)
                    .foregroundColor(.blue)
                    .allRounded(radius: 12, borderColor: .blue, borderWidth: 2)
                
                Button("Rounded") {}
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .allRounded(radius: 25)
            }
        }
    }
    
    private var formElementExample: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Form Elements")
                .font(.headline)
                .foregroundColor(.orange)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Email")
                        .frame(width: 60, alignment: .leading)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 40)
                        .topRounded(radius: 8, borderColor: .gray.opacity(0.3), borderWidth: 1)
                        .overlay(
                            Text("user@example.com")
                                .foregroundColor(.secondary)
                                .padding(.leading, 12),
                            alignment: .leading
                        )
                }
                
                HStack {
                    Text("Phone")
                        .frame(width: 60, alignment: .leading)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 40)
                        .bottomRounded(radius: 8, borderColor: .gray.opacity(0.3), borderWidth: 1)
                        .overlay(
                            Text("+1 (555) 123-4567")
                                .foregroundColor(.secondary)
                                .padding(.leading, 12),
                            alignment: .leading
                        )
                }
            }
        }
    }
    
    private var navigationExample: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Navigation & Modals")
                .font(.headline)
                .foregroundColor(.purple)
            
            VStack(spacing: 12) {
                Rectangle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 60)
                    .topRounded(radius: 16)
                    .overlay(
                        Text("Navigation Header")
                            .font(.headline)
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(height: 100)
                    .bottomRounded(radius: 20, borderColor: .gray.opacity(0.2), borderWidth: 1)
                    .overlay(
                        VStack {
                            Text("Modal Content")
                                .font(.headline)
                            Text("Beautifully rounded modal with selective corners")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    )
            }
        }
    }
    
    // MARK: - Footer Section
    private var footerSection: some View {
        VStack(spacing: 16) {
            Divider()
                .padding(.vertical, 8)
            
            VStack(spacing: 8) {
                Text("CornerCraft Showcase")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("Selective Corner Rounding for SwiftUI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Created by Dustin Nuzzo")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper Functions
    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Rectangle()
                .fill(LinearGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                .frame(width: 50, height: 3)
                .allRounded(radius: 2)
        }
    }
}

// MARK: - Preview
public struct CornerCraftShowcase_Previews: PreviewProvider {
    public static var previews: some View {
        CornerCraftShowcase()
    }
}
