import SwiftUI

// OAuth2 stuff
let twitchapi = TwitchAPI()

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Unwood for Twitch").padding()
            Button(action: twitchapi.signIn) {
                Text("Sign in")
            }
            Button(action: twitchapi.getUsers) {
                Text("Get list of users")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
