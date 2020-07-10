import SwiftUI

// OAuth2 stuff
let twitchapi = TwitchAPI()

struct ContentView: View {
    var body: some View {
        if getAccessToken() == "No access token stored." {
            LoginPage()
        } else {
            TabView {
                FollowingPage().tabItem {
                        Image(systemName: "heart.fill")
                        Text("Following")
                }
                SettingsPage().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
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
