import SwiftUI
import OAuthSwift

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
                    oauthswift.authorizeURLHandler = SafariURLHandler(
                        viewController: UIApplication.shared.windows[0].rootViewController!,
                        oauthSwift: oauthswift
                    )
                    
                    checkIfSignedIn() // for conditional in ContentView
                    validate()
                }
        }
    }
}
