import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        return WKWebView(frame: .zero, configuration: config)
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
        let url = URL(string: self.url)!

        let request = URLRequest(url: url)
        view.load(request)
    }
}
