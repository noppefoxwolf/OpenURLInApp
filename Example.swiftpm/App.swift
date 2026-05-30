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
                
                Tab {
                    Link("Open Link", destination: .article)
                        .onOpenURL(prefersInAppReader: false)
                } label: {
                    Label("Link", systemImage: "link")
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
            openURL(.article)
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
                openURLInApp(.article, prefersInAppReader: prefersInAppReader)
            } label: {
                Text("Open Apple website")
            }
            Toggle("Reader", isOn: $prefersInAppReader)
        }
    }
}

extension URL {
    static var article: URL {
        URL(string: "https://www.apple.com/jp/newsroom/2026/05/apple-sports-expands-to-more-than-90-new-countries-and-regions/")!
    }
}
