import SwiftUI
import OAuthSwift

let BASE_URL = "https://api.twitch.tv/helix"
let CLIENT_ID = "cnhtxu8qinx7qizf5rl3q4geimqt2v"
let CLIENT_SECRET: String = getSecret()
let AUTH_URI = "https://id.twitch.tv/oauth2/authorize"
let TOKEN_URI = "https://id.twitch.tv/oauth2/token"
let REDIRECT_URI = "com.pollsmor.unwood://"
let SCOPE = "user:read:email"

func getSecret() -> String {
    var secret = ""
    
    let url = Bundle.main.url(forResource: "secret", withExtension: "txt")!
    if let contents = try? String(contentsOf: url, encoding: .utf8) {
        secret = contents
    }

    secret.removeLast() // for some reason there's a space at the end
    return secret
}

class TwitchAPI {
    let oauthswift: OAuth2Swift
    
    init() {
        oauthswift = OAuth2Swift(
            consumerKey: CLIENT_ID,
            consumerSecret: CLIENT_SECRET,
            authorizeUrl: AUTH_URI,
            accessTokenUrl: TOKEN_URI,
            responseType: "code"
        )
        
        oauthswift.allowMissingStateCheck = true
        oauthswift.authorizeURLHandler = SafariURLHandler(
            viewController: UIApplication.shared.windows[0].rootViewController!,
            oauthSwift: oauthswift
        )
    }
    
    func signIn() {
        oauthswift.authorize(
            withCallbackURL: REDIRECT_URI,
            scope: SCOPE, state: "") { result in
            switch result {
            case .success(let (credential, response, _)):
                print("Token: \(credential.oauthToken)")
                print("Response: \(response!.string!)")
            case .failure(let error):
                print("Error: \(error.description)")
                print("Description: \(error.localizedDescription)")
            }
        }
    }
    
    func getUsers() {
        oauthswift.client.request(BASE_URL + "/users", method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
            switch result {
            case .success(let response):
                print("Users Response: \(response.response)")
                print("String: \(response.string!)")
            case .failure(let error):
                print("Users Error: \(error)")
            }
        }
    }
}

