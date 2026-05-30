# OpenURLInApp

A SwiftUI library that opens URLs using in-app Safari View Controller (SFSafariViewController) instead of the external Safari browser.

## Features

- Easy integration with SwiftUI
- Optional Reader Mode support
- Replaces default `openURL` behavior
- Compatible with iOS 18+

## Requirements

- iOS 18.0+
- Swift 6.3+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/noppefoxwolf/OpenURLInApp.git", from: "0.1.0")
]
```

Or add it through Xcode:
1. File > Add Package Dependencies...
2. Enter the repository URL: `https://github.com/noppefoxwolf/OpenURLInApp.git`

## Building

Since this package targets iOS 18+, you need to build it with an iOS SDK:

### Using Xcode

Open `Package.swift` in Xcode and build normally. The scheme will automatically target iOS.

### Using xcodebuild

```bash
xcodebuild -scheme OpenURLInApp -destination 'platform=iOS Simulator,name=iPhone 16' build
```

### Using Swift Package Manager

Swift Package Manager's default `swift build` command targets macOS, so you need to specify an iOS destination:

```bash
swift build --destination .build/apple/Products/Debug-iphoneos/
```

Or use Xcode's build system for easier iOS builds.

## Usage

### Basic Usage

Apply the `onOpenURL(prefersInAppReader:)` modifier to your view:

```swift
import SwiftUI
import OpenURLInApp

struct ContentView: View {
    var body: some View {
        Link("Open Link", destination: URL(string: "https://example.com")!)
            .onOpenURL(prefersInAppReader: false)
    }
}
```

### With Reader Mode

Enable Reader Mode for supported web pages:

```swift
Link("Open Article", destination: URL(string: "https://example.com/article")!)
    .onOpenURL(prefersInAppReader: true)
```

### Using Environment Value

Access the `openURLInApp` action directly:

```swift
struct ContentView: View {
    @Environment(\.openURLInApp) var openURLInApp
    
    var body: some View {
        Button("Open URL") {
            openURLInApp(URL(string: "https://example.com")!)
        }
        .onOpenURLInApp()
    }
}
```

## How It Works

The library hooks into SwiftUI's `openURL` environment action and presents an `SFSafariViewController` instead of opening the URL in the external Safari browser. This provides a seamless in-app browsing experience.

## License

MIT License - See LICENSE file for details

## Author

[@noppefoxwolf](https://github.com/noppefoxwolf)
