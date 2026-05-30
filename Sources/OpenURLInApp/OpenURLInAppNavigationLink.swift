import SwiftUI
import SafariServices

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
