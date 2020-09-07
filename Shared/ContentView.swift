import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        if !currUser.isLoggedIn {
            LoginPage()
        } else {
            NavigationView {
                TabView {
                    LivePage().tabItem {
                        Image(systemName: "tv")
                        Text("Streams")
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    FollowingPage().tabItem {
                            Image(systemName: "heart.fill")
                            Text("Following")
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    SettingsPage().tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
        }
    }
}
