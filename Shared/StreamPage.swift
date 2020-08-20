import SwiftUI
import SwiftyJSON
import AVKit

struct StreamPage: View {
    let channel: String
    @State var player = AVPlayer()
    @State private var showExtraControls = false
    @State private var showChat = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // for back button
    @Environment(\.verticalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .regular {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: UIApplication.shared.windows[0].windowScene?.statusBarManager!.statusBarFrame.height)
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
                }
                WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood") // chat
            }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea([.top])
        } else {
            HStack(spacing: 0) {
                VideoPlayer(player: player)
                    .onAppear(perform: loadVideoPlayer)
                    .onDisappear() {
                        player.pause()
                    }
                    .onTapGesture(count: 2) {
                        withAnimation {
                            showChat.toggle()
                        }
                    }
                if showChat {
                    WebView(url: "https://www.twitch.tv/embed/" + channel + "/chat?darkpopout&parent=com.pollsmor.unwood") // chat
                }
            }
            .navigationBarTitle(channel)
        }
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
