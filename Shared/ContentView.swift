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
                }
                FollowingPage().tabItem {
                        Image(systemName: "heart.fill")
                        Text("Following")
                }.onAppear(perform: loadUserData) // need username to pull up followed channels list
                SettingsPage().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}
