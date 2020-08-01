import SwiftUI

class CurrentUser: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userData = User()
}

// Placeholder image during loading
let questionmark_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Question_mark_%28black%29.svg/1200px-Question_mark_%28black%29.svg.png"

struct User: Identifiable {
    var id: String = ""
    var login: String = ""
    var display_name: String = ""
    var views: Int = 0
    var offline_image_url: String = questionmark_url
    var avatar_url: String = questionmark_url
    var description: String = ""
    var follows = [UserFollow()] // array of followed channels
}

struct UserFollow {
    var userID: String = ""
    var username: String = ""
    var followed_at: String = "" // time
}

struct Stream: Identifiable {
    var id: String = "" // user ID
    var username: String = ""
    var login: String = "" // actual stream URL's name --> FACEIT TV is really faceittv
    var game_id: String = ""
    var title: String = ""
    var viewer_count: Int = 0
    var started_at: String = "" // time
    var language: String = ""
    var thumbnail_url: String = questionmark_url
}
