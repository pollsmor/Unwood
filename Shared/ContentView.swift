import SwiftUI

// OAuth2 stuff
let twitchapi = TwitchAPI()

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Unwood for Twitch").padding()
            Button(action: twitchapi.getPersonalData) {
                Text("Get personal data")
            }
        }
    }
}

// Why don't previews work?!?!
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
