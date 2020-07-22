import SwiftUI
import AVKit

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channelName: String
    
    var body: some View {
        VStack {
            WebView(url: base_url + channelName + base_url_2)
                .frame(maxHeight: 300.0)
            Spacer()
        }
    }
}

struct StreamPage_Previews: PreviewProvider {
    static var previews: some View {
        StreamPage(channelName: "pollsmor")
    }
}
