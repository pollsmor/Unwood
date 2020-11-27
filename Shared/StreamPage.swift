import SwiftUI
import SwiftyJSON
import AVKit

struct StreamPage: View {
    let channel: String
    let channelName: String
    @State private var player = AVPlayer()
    @State private var qualityOptions = [Video]()
    @State private var showActionSheet = false
    @Environment(\.verticalSizeClass) var verticalSizeClass // for landscape mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
                .frame(height: verticalSizeClass == .regular ? UIScreen.main.bounds.width / 16 * 9: UIScreen.main.bounds.height * 0.9)
                .onAppear(perform: loadVideoPlayer)
                .onDisappear() {
                    player.pause()
                }
            colorScheme == .light ?
                WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?parent=com.pollsmor.unwood") :
                WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood") // chat
        }.navigationBarTitle(channelName, displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.showActionSheet.toggle()
                                }) {
                Image(systemName: "gear")
                                }.actionSheet(isPresented: $showActionSheet) {
                                    ActionSheet(title: Text("Quality"), message: Text("Select a quality option."), buttons: qualityOptions.map { qualityOption in
                                        qualityOption.url != "cancel" ?
                                        .default(Text(qualityOption.quality)) {
                                            self.player = AVPlayer(url: URL(string: qualityOption.url)!)
                                            self.player.play()
                                        } : .cancel()
                                    })
                                }
        )
    }
    
    private func loadVideoPlayer() {
        try! AVAudioSession.sharedInstance().setCategory(.playback) // allow audio playback with mute switch on
        
        let url = URL(string: "http://localhost:8081/stream?channel=" + channel)!
        let request = URLRequest(url: url) // connnect to personal Node.js server
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try! JSON(data: data)
                var temp = [Video]() // store the quality options
                
                for qualityOption in json.arrayValue {
                    temp.append(
                        Video(
                            quality: qualityOption["quality"].string!,
                            url: qualityOption["url"].string!
                        )
                    )
                }
                
                temp.append(Video(quality: "", url: "cancel")) // for getting out of action sheet
                
                DispatchQueue.main.async {
                    qualityOptions = temp
                    player = AVPlayer(url: URL(string: json[0]["url"].string!)!) // play source quality by default
                    player.play()
                }
            }
        }.resume()
    }
}
