import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String

    private func getZoomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.userContentController.addUserScript(self.getZoomDisableScript())
        
        let url = URL(string: self.url)!
        let request = URLRequest(url: url)
        let view = WKWebView(frame: .zero, configuration: config)
        view.load(request)
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
    }
}
