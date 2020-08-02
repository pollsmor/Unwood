import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String

    private func getZoomDisableScript() -> WKUserScript { // barely have any space to work with as it is
        let source = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    private func getBitsRemoveScript() -> WKUserScript {
        let source = """
            var removeLeaderboard = function() {
                var el = document.querySelector(".channel-leaderboard");
                el.parentNode.removeChild(el);
                
                document.body.removeEventListener("click", removeLeaderboard);
            }

            document.body.addEventListener("click", removeLeaderboard);
        """
        return WKUserScript(source: source as String, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // Next two lines allow for playback without going into fullscreen
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.userContentController.addUserScript(self.getZoomDisableScript())
        config.userContentController.addUserScript(self.getBitsRemoveScript())
        
        let url = URL(string: self.url)!
        let request = URLRequest(url: url)
        let view = WKWebView(frame: .zero, configuration: config)
        view.load(request)
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
    }
}
