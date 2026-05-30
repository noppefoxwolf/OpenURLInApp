import SwiftUI

struct OpenURLInAppPresentationModifier: ViewModifier {
    let request: OpenURLInAppRequest?
    
    func body(content: Content) -> some View {
        content.overlay {
            OpenURLInAppNavigationLink(request: request)
        }
    }
}

struct OpenURLInAppRequest: Identifiable {
    let id: UUID
    let url: URL
    let entersReaderIfAvailable: Bool
}
