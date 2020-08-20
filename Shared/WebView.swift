import SwiftUI
import WebKit

struct WebView: UIViewRepresentable { // for chat embed
    let url: String

    private func getZoomDisableScript() -> WKUserScript { // barely have any space to work with as it is
        let source = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    private func getMoreChatSpaceScript() -> WKUserScript {
        let source = """
            var getMoreChatSpace = function() {
                var leaderboard = document.querySelector(".channel-leaderboard");
                leaderboard.parentNode.removeChild(leaderboard);

                var bottomBar = document.querySelector(".chat-input__buttons-container");
                bottomBar.parentNode.removeChild(bottomBar)
                
                document.body.removeEventListener("click", getMoreChatSpace);
            }

            document.body.addEventListener("click", getMoreChatSpace);
        """
        return WKUserScript(source: source as String, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // Next two lines allow for playback without going into fullscreen
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.userContentController.addUserScript(self.getZoomDisableScript())
        config.userContentController.addUserScript(self.getMoreChatSpaceScript())
        
        let url = URL(string: self.url)!
        let request = URLRequest(url: url)
        let view = WKWebView(frame: .zero, configuration: config)
        view.load(request)
        
        view.frame.size.height = 1
        view.frame.size = view.scrollView.contentSize
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
    }
}
