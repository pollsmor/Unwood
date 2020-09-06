import SwiftUI
import SwiftyJSON
import AVKit

struct StreamPage: View {
    let channel: String
    @State var player = AVPlayer()
    @State private var showExtraControls = false
    @State private var showChat = true
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
                .frame(height: verticalSizeClass == .regular ? UIScreen.main.bounds.width / 16 * 9: UIScreen.main.bounds.height * 0.8)
                .onAppear(perform: loadVideoPlayer)
                .onDisappear() {
                    player.pause()
                }
            WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood") // chat
        }.navigationBarTitle(channel, displayMode: .inline)
    }
    
    private func loadVideoPlayer() {
        try! AVAudioSession.sharedInstance().setCategory(.playback) // allow audio playback with mute switch on
        
        let url = URL(string: "http://localhost:8081/stream?channel=" + channel)!
        let request = URLRequest(url: url) // connnect to personal Node.js server
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try! JSON(data: data)
                print(json)
                DispatchQueue.main.async {
                    player = AVPlayer(url: URL(string: json[0]["url"].string!)!)
                    player.play()
                }
            }
        }.resume()
    }
}
