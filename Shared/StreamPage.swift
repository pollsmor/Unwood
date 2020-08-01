import SwiftUI
import SwiftyJSON
import AVKit

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channel: String
    @State var player = AVPlayer()
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
            WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood")
        }
        .onAppear() {
            try! AVAudioSession.sharedInstance().setCategory(.playback)
            
            let url = URL(string: "http://localhost:8081/stream?channel=" + channel)!
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let json = try! JSON(data: data)
                    print(json)
                    DispatchQueue.main.async {
                        player = AVPlayer(url: URL(string: json[0]["url"].string!)!)
                    }
                } else {
                    print("Could not connect to Node.js server.")
                }
            }.resume()
        }
    }
}
