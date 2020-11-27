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
                        .navigationBarTitle("Streams")
                }
                .tabItem {
                    Image(systemName: "tv")
                    Text("Streams")
                }
                NavigationView {
                    FollowingPage()
                        .navigationBarTitle("Followed channels")
                }
                .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Following")
                }
                NavigationView {
                    SettingsPage()
                        .navigationBarTitle("Settings")
                }
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}
