# Unwood
(Learning SwiftUI) Third-party Twitch client for iOS 14+

The name of the app is an inside joke, but so are most of the stuff I name :)

Demo video: https://streamable.com/zhlq3p

This is recorded in Xcode 12 beta 5's simulator.

## Currently supported features
- Login with Twitch mechanism (asks for login again when access token expires)
- View list of live channels being followed (thumbnail, channel name, title, viewer count)
- View list of all followed channels (sorted by how recent the follow was)
- Settings page (only shows profile information atm)
- Click on a stream to pull up the chat (uses a WebView of the popout chat as I can't find a good and simple IRC library for Swift)
  - That means you will have to log in twice for full functionality
- Also pulls up the video from the direct m3u8 URL
  - Quality options
- Chat window adapts to whether the system theme is light or dark (may require refreshing a stream to take effect)

## Technical details that I guess people may want to know ##
- OAuth2 flow: implicit (as [recommended](https://dev.twitch.tv/docs/authentication#getting-tokens) by Twitch), does not use a client secret
- iOS 14 and above only (Xcode 12+) as this uses the new SwiftUI app lifecycle without AppDelegate or SceneDelegate
- Necessitates the use of a Node.js server to provide direct stream URL (feels like a very ghetto solution, not sure if I should keep using this, oh yeah it's not HTTPS)
- Not recommended to be run on a 4-inch iDevice due to space constraints
- Handling landscape forces both the video player and chat to completely refresh, which is obviously undesirable. For now I'll avoid this by using the same layout for portrait and lanscape (not sure if this can be fixed)
- Manually tapping any part of the chat window causes the bits section to disappear in an attempt to save screen space. The automatic alternative would be wasteful (running the JavaScript remove code every few seconds, as I have no clue when the page fully loads on the client's side).
- The navigation bar is hidden on the main three pages. This is undesirable, but necessary to hide the bottom tab bar when viewing a stream (for extra screen space).

## Required libraries ##
Install using the Swift Package Manager.
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [RemoteImage](https://github.com/crelies/RemoteImage)
