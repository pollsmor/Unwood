import SwiftUI
import OAuthSwift

class CurrentUser: ObservableObject {
    @Published var isLoggedIn = false
}

var currUser = CurrentUser()

@main
struct UnwoodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currUser)
                .onOpenURL { url in
                    OAuthSwift.handle(url: url) // no longer doing this in SceneDelegate like on iOS 13
                }
                .onAppear() {
                }
        }
    }
}
