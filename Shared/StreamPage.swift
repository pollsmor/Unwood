import SwiftUI

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channelName: String
    @State private var showToolbar = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                WebView(url: base_url + channelName + base_url_2)
                    .frame(minHeight: 250.0)
                    .onTapGesture() {
                        showToolbar.toggle()
                    }
                if showToolbar {
                    HStack {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }) {
                            Text("< Streams")
                                .foregroundColor(.blue)
                                .padding(8.0)
                        }
                        Spacer()
                        Text(channelName)
                            .padding(8.0)
                    }.background(Color.white)
                    .transition(.slide)
                    .animation(.default)
                } else {
                    EmptyView()
                }
            }
            WebView(url: "https://www.twitch.tv/embed/" + channelName + "/chat?darkpopout&parent=com.pollsmor.unwood")
        }.navigationBarHidden(true)
    }
}

struct StreamPage_Previews: PreviewProvider {
    static var previews: some View {
        StreamPage(channelName: "pollsmor")
    }
}
