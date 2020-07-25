import SwiftUI

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channelName: String
    
    var body: some View {
        VStack(spacing: 0) {
            WebView(url: base_url + channelName + base_url_2)
                .frame(maxHeight: UIScreen.main.bounds.width / 16 * 9)
            WebView(url: "https://www.twitch.tv/embed/pollsmor/chat?darkpopout&parent=com.pollsmor.unwood")
        }
    }
}

struct StreamPage_Previews: PreviewProvider {
    static var previews: some View {
        StreamPage(channelName: "pollsmor")
    }
}
