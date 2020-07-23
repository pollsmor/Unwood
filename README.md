# Unwood
(Learning SwiftUI) Third-party Twitch client for iOS 14+

## Currently supported features
- Login with Twitch mechanism
- View list of live channels being followed (thumbnail, channel name, title, viewer count)
- View list of all followed channels (sorted by how recent the follow was)
- Settings page (only shows profile information atm)
- Click on a stream to pull up the stream (uses a WebView of the popout Twitch player as there are many difficulties getting a native video player working)
- Next step: chat functionality (which I think will be one of the biggest hurdles!)

## Technical details that I guess people may want to know ##
- OAuth2 flow: implicit (as [recommended](https://dev.twitch.tv/docs/authentication#getting-tokens) by Twitch), does not use a client secret
- iOS 14 and above only (Xcode 12+) as this uses the new SwiftUI app lifecycle without AppDelegate or SceneDelegate

## Required libraries ##
Install using the Swift Package Manager.
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [RemoteImage](https://github.com/crelies/RemoteImage)
