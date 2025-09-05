# CornerCraft

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**🎨 Selective corner rounding for SwiftUI with style and precision**

CornerCraft provides an elegant solution for applying corner rounding to specific corners of SwiftUI views. With fine-grained control, 12 convenient preset modifiers, built-in animations, and a beautiful interactive showcase, it makes selective corner rounding simple, intuitive, and visually stunning.

<p align="center">
  <img src="Screenshot%201.png" alt="Screenshot 1" width="300" />
  <img src="Screenshot%202.png" alt="Screenshot 2" width="300" />
</p>

## ✨ Features

- 🎯 **Selective Corner Control** - Round specific corners using UIRectCorner
- 🎨 **12 Convenient Presets** - Ready-to-use modifiers for all corner combinations
- ✨ **Built-in Animations** - 6 animation types: easeInOut, spring, linear, easeIn, easeOut, and none
- 🖼️ **Optional Borders** - Configurable border color and width
- 🎪 **Interactive Showcase** - Beautiful demo view with live parameter controls
- 🚀 **SwiftUI Native** - Built specifically for SwiftUI with modern APIs
- 📦 **Lightweight** - Zero dependencies, minimal footprint

## 🚀 Quick Start

```swift
import SwiftUI
import CornerCraft

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Round specific corners
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .topLeftRounded(radius: 20)
            
            // Round multiple corners with border
            Text("Hello, CornerCraft!")
                .padding()
                .background(Color.gray.opacity(0.2))
                .topRounded(radius: 15, borderColor: .blue, borderWidth: 2)
            
            // Built-in animations - no extra .animation() needed!
            Rectangle()
                .fill(Color.green)
                .frame(width: 100, height: 100)
                .allRounded(radius: isAnimated ? 50 : 10, animationType: .spring(duration: 0.6, bounce: 0.3))
        }
    }
}
```

## 📦 Installation

### Swift Package Manager

Add CornerCraft to your project using Xcode:

1. File → Add Package Dependencies
2. Enter: `https://github.com/onlydstn/CornerCraft`
3. Select your desired version

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/onlydstn/CornerCraft", from: "1.0.0")
]
```

### CocoaPods

```ruby
pod 'CornerCraft', '~> 1.0'
```

### Manual Installation

1. Download the source files
2. Add `CornerCraftShape.swift` and `CornerCraftModifiers.swift` to your project

## 📖 API Reference

### Core API

#### `.cornerCraft(_:radius:borderColor:borderWidth:)`

The main modifier for custom corner configurations.

```swift
func cornerCraft(
    _ corners: UIRectCorner,
    radius: CGFloat,
    borderColor: Color? = nil,
    borderWidth: CGFloat = 0,
    animationType: CornerCraftAnimationType = .none
) -> some View
```

**Parameters:**
- `corners`: UIRectCorner specifying which corners to round
- `radius`: Corner radius value
- `borderColor`: Optional border color
- `borderWidth`: Border width (default: 0)
- `animationType`: Animation type for radius changes (default: .none)

**Example:**
```swift
Rectangle()
    .cornerCraft([.topLeft, .bottomRight], radius: 25, animationType: .easeInOut(duration: 0.5))
```

### Animation Types

CornerCraft includes built-in animation support with 6 animation types:

```swift
public enum CornerCraftAnimationType {
    case none                                    // No animation
    case easeInOut(duration: Double = 0.3)      // Smooth ease in and out
    case spring(duration: Double = 0.6, bounce: Double = 0.0) // Spring animation with bounce
    case linear(duration: Double = 0.3)         // Constant speed animation
    case easeIn(duration: Double = 0.3)         // Slow start, fast end
    case easeOut(duration: Double = 0.3)        // Fast start, slow end
}
```

**Examples:**
```swift
// Spring animation with bounce
Rectangle()
    .allRounded(radius: 20, animationType: .spring(duration: 0.8, bounce: 0.4))

// Smooth ease in-out
Rectangle()
    .topRounded(radius: 15, animationType: .easeInOut(duration: 0.5))

// Linear animation
Rectangle()
    .bottomLeftRounded(radius: 10, animationType: .linear(duration: 0.3))
```

### Preset Modifiers

CornerCraft provides 12 convenient preset modifiers:

#### Individual Corners
```swift
.topLeftRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)
.topRightRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none) 
.bottomLeftRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)
.bottomRightRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)
```

#### Side Combinations
```swift
.topRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)      // topLeft + topRight
.bottomRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)   // bottomLeft + bottomRight
.leftRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)     // topLeft + bottomLeft
.rightRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)    // topRight + bottomRight
```

#### Diagonal Combinations
```swift
.topLeftBottomRightRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)  // diagonal \
.topRightBottomLeftRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)  // diagonal /
```

#### Special Cases
```swift
.allRounded(radius: CGFloat, animationType: CornerCraftAnimationType = .none)      // all corners
.noneRounded(animationType: CornerCraftAnimationType = .none)                      // no rounding (rectangular)
```

All preset modifiers support optional border and animation parameters:
```swift
.topRounded(radius: 20, borderColor: .blue, borderWidth: 2, animationType: .spring())
```

## 💡 Usage Examples

### Basic Corner Rounding

```swift
// Single corner
Rectangle()
    .fill(Color.red)
    .frame(width: 100, height: 100)
    .topLeftRounded(radius: 20)

// Multiple corners
Rectangle()
    .fill(Color.blue)
    .frame(width: 100, height: 100)
    .cornerCraft([.topLeft, .bottomRight], radius: 25)
```

### With Borders

```swift
Text("Bordered Content")
    .padding()
    .background(Color.gray.opacity(0.1))
    .topRounded(radius: 12, borderColor: .accentColor, borderWidth: 2)
```

### Built-in Animations

```swift
@State private var isExpanded = false

Rectangle()
    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
    .frame(width: 120, height: 120)
    .allRounded(radius: isExpanded ? 60 : 12, animationType: .spring(duration: 0.6, bounce: 0.3))
    .onTapGesture {
        isExpanded.toggle()
    }

// Multiple animation types
VStack {
    Rectangle().topRounded(radius: animated ? 20 : 5, animationType: .easeInOut())
    Rectangle().bottomRounded(radius: animated ? 20 : 5, animationType: .spring())
    Rectangle().allRounded(radius: animated ? 20 : 5, animationType: .linear())
}
```

### Common UI Patterns

#### Card Components
```swift
VStack(alignment: .leading, spacing: 12) {
    Text("Card Title")
        .font(.headline)
    Text("Card content goes here...")
        .font(.body)
}
.padding()
.background(Color(.systemBackground))
.topRounded(radius: 16)
.shadow(radius: 4)
```

#### Button Styles
```swift
Button("Primary Action") {
    // Action
}
.padding(.horizontal, 20)
.padding(.vertical, 12)
.background(Color.accentColor)
.foregroundColor(.white)
.allRounded(radius: 12)
```

#### Form Elements
```swift
TextField("Enter text", text: $text)
    .textFieldStyle(.plain)
    .padding()
    .background(Color(.systemGray6))
    .topRounded(radius: 8, borderColor: .gray.opacity(0.3), borderWidth: 1)
```

## 🎨 Advanced Usage

### Dynamic Corner Radius

```swift
let cornerRadius = min(geometry.size.width, geometry.size.height) * 0.25

Rectangle()
    .fill(Color.orange)
    .allRounded(radius: cornerRadius)
```

### Conditional Rounding

```swift
Rectangle()
    .fill(Color.green)
    .cornerCraft(
        isSpecialMode ? [.topLeft, .bottomRight] : .allCorners,
        radius: 20
    )
```

### Responsive Design

```swift
Rectangle()
    .fill(Color.purple)
    .allRounded(radius: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16)
```

## 🎪 Interactive Showcase

CornerCraft includes a beautiful interactive showcase that demonstrates all features in real-time. The showcase is perfect for:

- **Learning**: See how each modifier and animation type works
- **Experimenting**: Test different corner combinations and parameters
- **Prototyping**: Quickly try ideas before implementing them

### Using the Showcase

```swift
import SwiftUI
import CornerCraft

struct ContentView: View {
    var body: some View {
        CornerCraftShowcase()
    }
}
```

### Showcase Features

- 🎯 **Interactive Header Demo**: Live preview with real-time parameter changes
- ⚙️ **Corner Selection**: Visual buttons for all corner combinations
- 🎚️ **Parameter Controls**: Sliders for radius and border width
- 🎨 **Color Picker**: Border color selection with visual feedback
- 🎭 **Animation Demos**: Compare all 6 animation types side-by-side
- 📱 **Preset Gallery**: Visual showcase of all 12 preset modifiers
- 🎪 **Real-World Examples**: Common UI patterns and use cases

The showcase uses smooth animations and provides immediate visual feedback, making it easy to understand how CornerCraft works and discover the perfect settings for your UI.

## 📋 Requirements

- iOS 16.0+ 
- Swift 5.9+
- Xcode 15.0+

## 📄 License

CornerCraft is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## 👨‍💻 Author

Created by Dustin Nuzzo

---

⭐ If you found CornerCraft helpful, please consider giving it a star!
