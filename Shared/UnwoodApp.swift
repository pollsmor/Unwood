import SwiftUI
import OAuthSwift

@main
struct UnwoodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                OAuthSwift.handle(url: url) // no longer doing this in SceneDelegate like on iOS 13
            }
        }
    }
}
