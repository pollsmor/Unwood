import SwiftUI
import OAuthSwift

let BASE_URL = "https://api.twitch.tv/helix"
let CLIENT_ID = "cnhtxu8qinx7qizf5rl3q4geimqt2v"
let AUTH_URI = "https://id.twitch.tv/oauth2/authorize"
let TOKEN_URI = "https://id.twitch.tv/oauth2/token"
let VALIDATE_URI = "https://id.twitch.tv/oauth2/validate"
let REDIRECT_URI = "com.pollsmor.unwood://"
let SCOPE = "user:read:email"

/*
func getSecret() -> String { // not useful for implicit flow, but leaving it in
    var secret = ""
    
    let url = Bundle.main.url(forResource: "secret", withExtension: "txt")!
    if let contents = try? String(contentsOf: url, encoding: .utf8) {
        secret = contents
    }

    secret.removeLast() // for some reason there's a space at the end
    return secret
}
*/

func getAccessToken() -> String {
    let defaults = UserDefaults.standard
    if let token = defaults.value(forKey: "accessToken") as? String {
        return token
    }
    
    return "No access token stored."
}

func setAccessToken(token: String) {
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: "accessToken")
}

class TwitchAPI {
    let oauthswift: OAuth2Swift
    
    init() {
        oauthswift = OAuth2Swift(
            consumerKey: CLIENT_ID,
            consumerSecret: "",
            authorizeUrl: AUTH_URI,
            accessTokenUrl: TOKEN_URI,
            responseType: "token"
        )
        
        oauthswift.allowMissingStateCheck = true
        oauthswift.authorizeURLHandler = SafariURLHandler(
            viewController: UIApplication.shared.windows[0].rootViewController!,
            oauthSwift: oauthswift
        )
        
        signIn()
    }
    
    func signIn() {
        let accessToken = getAccessToken()
        if accessToken != "No access token stored." {
            print("Already signed in! Access token: \(accessToken)")
            oauthswift.client.credential.oauthToken = accessToken
        } else {
            print("Not signed in yet.")
            oauthswift.authorize(
                withCallbackURL: REDIRECT_URI,
                scope: SCOPE, state: "") { result in
                switch result {
                case .success(let (credential, _, _)):
                    print("Token: \(credential.oauthToken)")
                    setAccessToken(token: credential.oauthToken)
                case .failure(let error):
                    print("Auth error: \(error.description)")
                }
            }
        }
    }
    
    func validate() { // required to do this periodically as per Twitch API docs
        oauthswift.client.request(VALIDATE_URI, method: .GET) { result in
            switch result {
            case .success(let response):
                print("Validation response: \(response.string!)")
            case .failure(let error):
                print("Validation error: \(error)")
                self.signIn()
            }
        }
    }
    
    func getPersonalData() {
        validate()
        
        oauthswift.client.request(BASE_URL + "/users", method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
            switch result {
            case .success(let response):
                //print("Users Response: \(response.response)")
                print("Users response: \(response.string!)")
            case .failure(let error):
                print("Users error: \(error)")
            }
        }
    }
}

