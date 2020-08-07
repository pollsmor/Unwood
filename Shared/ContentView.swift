import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        if !currUser.isLoggedIn {
            LoginPage()
        } else {
            TabView {
                LivePage().tabItem {
                    Image(systemName: "tv")
                    Text("Streams")
                }.onAppear(perform: loadUserData) // need username to pull up followed channels list
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
