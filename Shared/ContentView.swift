import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: User
    
    var body: some View {
        if !userData.isLoggedIn {
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
            .environmentObject(userData)
    }
}
