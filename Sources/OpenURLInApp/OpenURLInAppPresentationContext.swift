import SwiftUI
import SafariServices

struct OpenURLInAppPresentationContext: UIViewControllerRepresentable {
    let request: OpenURLInAppRequest?
    
    func makeUIViewController(context: Context) -> PresentationContextViewController {
        PresentationContextViewController()
    }
    
    func updateUIViewController(_ uiViewController: PresentationContextViewController, context: Context) {
        context.coordinator.presentationContext = uiViewController
        context.coordinator.request = request
    }
    
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiViewController: PresentationContextViewController,
        context: Context
    ) -> CGSize? {
        .zero
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator {
        weak var presentationContext: PresentationContextViewController? = nil
        var request: OpenURLInAppRequest? {
            didSet {
                if let request, oldValue?.id != request.id {
                    presentationContext?.presentSafariViewController(
                        request.url,
                        entersReaderIfAvailable: request.entersReaderIfAvailable
                    )
                }
            }
        }
    }
}

final class PresentationContextViewController: UIViewController {
    func presentSafariViewController(_ url: URL, entersReaderIfAvailable: Bool) {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        let vc = SFSafariViewController(url: url, configuration: configuration)
        present(vc, animated: true)
    }
}
