import SwiftUI

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
