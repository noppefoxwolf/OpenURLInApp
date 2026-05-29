import SwiftUI
import OpenURLInApp

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab {
                    OpenURLContentView()
                        .onOpenURL(prefersInAppReader: false)
                } label: {
                    Label("Hooked", systemImage: "safari")
                }
                
                Tab {
                    OpenURLInAppContentView()
                        .onOpenURLInApp()
                } label: {
                    Label("Direct", systemImage: "safari")
                }
                
                Tab {
                    OpenURLContentView()
                } label: {
                    Label("openURL", systemImage: "safari")
                }
            }
        }
    }
}

struct OpenURLContentView: View {
    @Environment(\.openURL)
    var openURL
    
    var body: some View {
        Button {
            let url = URL(string: "https://www.apple.com/jp/newsroom/2026/05/apple-sports-expands-to-more-than-90-new-countries-and-regions/")!
            openURL(url)
        } label: {
            Text("Open Apple website")
        }
    }
}

struct OpenURLInAppContentView: View {
    @Environment(\.openURLInApp)
    var openURLInApp
    
    @State
    var prefersInAppReader: Bool = false
    
    var body: some View {
        VStack {
            Button {
                let url = URL(string: "https://www.apple.com/jp/newsroom/2026/05/apple-sports-expands-to-more-than-90-new-countries-and-regions/")!
                openURLInApp(url, prefersInAppReader: prefersInAppReader)
            } label: {
                Text("Open Apple website")
            }
            Toggle("Reader", isOn: $prefersInAppReader)
        }
    }
}

