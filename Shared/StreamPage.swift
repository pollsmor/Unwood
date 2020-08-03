import SwiftUI
import SwiftyJSON
import AVKit

struct StreamPage: View {
    let channel: String
    @State var player = AVPlayer()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // for back button
    @State private var showExtraControls = false
    
    var body: some View {
        VStack(spacing: 0) {
            VideoPlayer(player: player)
                .frame(height: UIScreen.main.bounds.size.width / 16 * 9)
                .onAppear(perform: loadVideoPlayer)
                .onDisappear() {
                    player.pause()
                }
                .onTapGesture() {
                    withAnimation {
                        showExtraControls.toggle()
                    }
                }
            if showExtraControls {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 4.0) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24.0, weight: .medium))
                            Text("Streams")
                        }
                    }
                }.padding(10.0)
            } else {
                EmptyView()
            }
            WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood") // chat
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private func loadVideoPlayer() {
        try! AVAudioSession.sharedInstance().setCategory(.playback) // allow audio playback with mute switch on
        
        let url = URL(string: "http://2.tcp.ngrok.io:14716/stream?channel=" + channel)!
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
