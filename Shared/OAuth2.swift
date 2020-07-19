import SwiftUI
import OAuthSwift
import SwiftyJSON

let BASE_URL = "https://api.twitch.tv/helix"
let CLIENT_ID = "cnhtxu8qinx7qizf5rl3q4geimqt2v"
let AUTH_URI = "https://id.twitch.tv/oauth2/authorize"
let TOKEN_URI = "https://id.twitch.tv/oauth2/token"
let VALIDATE_URI = "https://id.twitch.tv/oauth2/validate"
let REDIRECT_URI = "com.pollsmor.unwood://"
let SCOPE = "user:read:email"

let oauthswift = OAuth2Swift(
    consumerKey: CLIENT_ID,
    consumerSecret: "",
    authorizeUrl: AUTH_URI,
    accessTokenUrl: TOKEN_URI,
    responseType: "token" // implicit flow; "code" = authorization flow
)
    
func checkIfSignedIn() {
    let accessToken = getAccessToken()
    
    if accessToken != "No access token stored." {
        oauthswift.client.credential.oauthToken = accessToken
        currUser.isLoggedIn = true // cause ContentView to render main page instead of login page
    }
}

func signIn() {
    let state = randomString(length: 30)
    oauthswift.authorize(
        withCallbackURL: REDIRECT_URI,
        scope: SCOPE, state: state) { result in
        switch result {
        case .success(let (credential, _, parameters)):
            if parameters["state"] as! String == state {
                print("[State] parameter validated, saving access token.")
                storeAccessToken(token: credential.oauthToken)
                currUser.isLoggedIn = true
            } else {
                print("[State] parameter does not match. Not logging in.")
            }
        case .failure(let error):
            print("Auth error: \(error.description)")
        }
    }
}

func validate() { // required to do this periodically as per Twitch API docs
    oauthswift.client.request(VALIDATE_URI, method: .GET) { result in
        switch result {
        case .success(let response):
            print("Validation response: \(response.string!)")
        case .failure(let error): // access token no longer valid
            print("Validation error: \(error)")
            storeAccessToken(token: "No access token stored.")
            signIn() // log in again with stored cookies to obtain another token (should be automatic)
        }
    }
}

// Helper functions ===================================================
func getAccessToken() -> String {
    let defaults = UserDefaults.standard
    if let token = defaults.value(forKey: "accessToken") as? String {
        return token
    }
    
    return "No access token stored."
}

func storeAccessToken(token: String) {
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: "accessToken")
}

func randomString(length: Int) -> String { // for generating random state parameter
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
