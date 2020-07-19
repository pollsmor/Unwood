# Unwood
(Learning SwiftUI) Third-party Twitch client for iOS 14+

## Technical details that I guess people may want to know ##
- OAuth2 flow: implicit (as [recommended](https://dev.twitch.tv/docs/authentication#getting-tokens) by Twitch), does not use a client secret
- iOS 14 and above only as this uses the new SwiftUI app lifecycle without AppDelegate or SceneDelegate

## Required libraries ##
Install using the Swift Package Manager.
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
