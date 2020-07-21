import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.load(request)
        return webview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
