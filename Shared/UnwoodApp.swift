import SwiftUI
import OAuthSwift

class User: ObservableObject {
    @Published var isLoggedIn = false
}

var userData = User()

@main
struct UnwoodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .onOpenURL { url in
                    OAuthSwift.handle(url: url) // no longer doing this in SceneDelegate like on iOS 13
                }
                .onAppear() {
                }
        }
    }
}
