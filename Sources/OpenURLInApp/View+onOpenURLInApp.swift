import SwiftUI

extension View {
    public func onOpenURLInApp() -> some View {
        modifier(OnOpenURLInAppViewModifier())
    }
}

struct OnOpenURLInAppViewModifier: ViewModifier {
    @State
    var request: OpenURLInAppRequest? = nil
    
    func body(content: Content) -> some View {
        content
            .environment(\.openURLInApp, OpenURLInAppAction(handler: { (url, prefersInAppReader) in
                .defaultAction(url, prefersInAppReader: prefersInAppReader)
            }, action: { result in
                request = OpenURLInAppRequest(id: UUID(), url: result.url, entersReaderIfAvailable: result.prefersInAppReader)
            }))
            .modifier(OpenURLInAppPresentationModifier(request: request))
    }
}
