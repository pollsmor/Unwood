import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        if !currUser.isLoggedIn {
            LoginPage()
        } else {
            TabView {
                NavigationView {
                    LivePage()
                        .navigationBarHidden(true)
                }
                .tabItem {
                    Image(systemName: "tv")
                    Text("Streams")
                }
                NavigationView {
                    FollowingPage()
                        .navigationBarHidden(true)
                }
                .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Following")
                }
                NavigationView {
                    SettingsPage()
                        .navigationBarHidden(true)
                }
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}
