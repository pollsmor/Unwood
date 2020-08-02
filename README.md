# Unwood
(Learning SwiftUI) Third-party Twitch client for iOS 14+

Demo video: https://streamable.com/vj8kxw

*Xcode 12 beta 3 has an issue with horrible performance of WebViews/VideoPlayers when in the iOS simulator. This issue is not present on a physical device.*

## Currently supported features
- Login with Twitch mechanism
- View list of live channels being followed (thumbnail, channel name, title, viewer count)
- View list of all followed channels (sorted by how recent the follow was)
- Settings page (only shows profile information atm)
- Click on a stream to pull up the chat (uses a WebView of the popout chat as I can't find a good and simple IRC library for Swift)
- Also pulls up the video from the direct m3u8 URL
  - Video's audio keeps playing in the background + restarts when going back (undesired)

## Technical details that I guess people may want to know ##
- OAuth2 flow: implicit (as [recommended](https://dev.twitch.tv/docs/authentication#getting-tokens) by Twitch), does not use a client secret
- iOS 14 and above only (Xcode 12+) as this uses the new SwiftUI app lifecycle without AppDelegate or SceneDelegate
- Necessitates the use of a Node.js server to provide direct stream URL (feels like a very ghetto solution, not sure if I should keep using this, oh yeah it's not HTTPS)

## Required libraries ##
Install using the Swift Package Manager.
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [RemoteImage](https://github.com/crelies/RemoteImage)
