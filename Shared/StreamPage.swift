import SwiftUI

let base_url = "https://player.twitch.tv/?channel="
let base_url_2 = "&enableExtensions=false&muted=false&parent=twitch.tv&player=popout&volume=1.0"

struct StreamPage: View {
    let channelName: String
    @State private var showToolbar = false
    @State private var opacity = 1.0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                WebView(url: base_url + channelName + base_url_2)
                    .frame(minHeight: 250.0)
                    .opacity(opacity)
                    .onTapGesture() {
                        showToolbar.toggle()
                        if opacity == 1.0 {
                            opacity = 0.3
                        } else {
                            opacity = 1.0
                        }
                    }
                    .transition(.opacity)
                    .animation(.default)
                if showToolbar {
                    HStack {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }) {
                            Text("< Streams")
                        }
                        Spacer()
                        Text("pollsmor")
                    }.background(Color.black)
                    .padding(.init(top: 8.0, leading: 8.0, bottom: 16.0, trailing: 8.0))
                    .transition(.opacity)
                    .animation(.default)
                } else {
                    EmptyView()
                }
            }
            WebView(url: "https://www.twitch.tv/embed/" + channelName + "/chat?darkpopout&parent=com.pollsmor.unwood")
        }
    }
}

struct StreamPage_Previews: PreviewProvider {
    static var previews: some View {
        StreamPage(channelName: "pollsmor")
    }
}
