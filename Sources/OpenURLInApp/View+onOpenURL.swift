import SwiftUI

extension View {
    public func onOpenURL(prefersInAppReader: Bool) -> some View {
        hookOpenURLToOpenURLInApp(prefersInAppReader: prefersInAppReader)
            .onOpenURLInApp()
    }
}

extension View {
    func hookOpenURLToOpenURLInApp(prefersInAppReader: Bool) -> some View {
        modifier(HookOpenURLToOpenURLInAppViewModifier(prefersInAppReader: prefersInAppReader))
    }
}

struct HookOpenURLToOpenURLInAppViewModifier: ViewModifier {
    let prefersInAppReader: Bool
    
    @Environment(\.openURLInApp)
    var openURLInApp
    
    func body(content: Content) -> some View {
        content
            .environment(\.openURL, OpenURLAction(handler: { url in
                openURLInApp(url, prefersInAppReader: prefersInAppReader)
                return .handled
            }))
    }
}
