import SwiftUI
import SafariServices

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

extension EnvironmentValues {
    @Entry
    public var openURLInApp: OpenURLInAppAction = .noop
}

public struct OpenURLInAppAction {
    let handler: (URL, _ prefersInAppReader: Bool) -> Result
    let action: (Result) -> Void
    
    struct Result {
        let url: URL
        let prefersInAppReader: Bool
        
        static func defaultAction(_ url: URL, prefersInAppReader: Bool = false) -> Result {
            Result(url: url, prefersInAppReader: prefersInAppReader)
        }
    }
    
    static var noop: OpenURLInAppAction {
        .init(handler: { .defaultAction($0, prefersInAppReader: $1) }, action: { _ in })
    }
    
    public func callAsFunction(_ url: URL) {
        action(handler(url, false))
    }
    
    public func callAsFunction(_ url: URL, prefersInAppReader: Bool) {
        action(handler(url, prefersInAppReader))
    }
}

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

struct OpenURLInAppNavigationLink: UIViewControllerRepresentable {
    let request: OpenURLInAppRequest?
    
    func makeUIViewController(context: Context) -> PresentationContextViewController {
        PresentationContextViewController()
    }
    
    func updateUIViewController(_ uiViewController: PresentationContextViewController, context: Context) {
        if let request {
            uiViewController.openURLInApp(
                request.url,
                entersReaderIfAvailable: request.entersReaderIfAvailable
            )
        }
    }
    
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiViewController: PresentationContextViewController,
        context: Context
    ) -> CGSize? {
        .zero
    }
}

final class PresentationContextViewController: UIViewController {
    func openURLInApp(_ url: URL, entersReaderIfAvailable: Bool) {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        let vc = SFSafariViewController(url: url, configuration: configuration)
        present(vc, animated: true)
    }
}
