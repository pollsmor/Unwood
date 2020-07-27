# Unwood
(Learning SwiftUI) Third-party Twitch client for iOS 14+

Demo video: https://streamable.com/anyrjv
*Xcode 12 beta 3 has an issue with horrible performance of WebViews when in the iOS simulator. This issue is not present on a physical device.*

## Currently supported features
- Login with Twitch mechanism
- View list of live channels being followed (thumbnail, channel name, title, viewer count)
- View list of all followed channels (sorted by how recent the follow was)
- Settings page (only shows profile information atm)
- Click on a stream to pull up the chat (uses a WebView of the popout chat as I can't find a good and simple IRC library for Swift)
- Also pulls up the video which at the moment is also a WebView - will try getting a native video player going

## Technical details that I guess people may want to know ##
- OAuth2 flow: implicit (as [recommended](https://dev.twitch.tv/docs/authentication#getting-tokens) by Twitch), does not use a client secret
- iOS 14 and above only (Xcode 12+) as this uses the new SwiftUI app lifecycle without AppDelegate or SceneDelegate

## Required libraries ##
Install using the Swift Package Manager.
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [RemoteImage](https://github.com/crelies/RemoteImage)
