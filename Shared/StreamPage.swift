import SwiftUI
import AVKit
import SwiftyJSON

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channelName: String
    @State var player = AVPlayer()
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
            WebView(url: "https://www.twitch.tv/embed/" + channelName + "/chat?darkpopout&parent=com.pollsmor.unwood")
        }
        .onAppear() {
            try! AVAudioSession.sharedInstance().setCategory(.playback)
            
            let url = URL(string: "http://0.tcp.ngrok.io:16327/stream?username=" + channelName)!
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                let json = try! JSON(data: data!)
                print(json)
                player = AVPlayer(url: URL(string: json[0]["url"].string!)!)
            }.resume()
        }
    }
}

struct StreamPage_Previews: PreviewProvider {
    static var previews: some View {
        StreamPage(channelName: "pollsmor")
    }
}
