import SwiftUI

struct User: Identifiable {
    var id: String = ""
    var login: String = ""
    var display_name: String = ""
    var views: Int = 0
    var offline_image_url: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Question_mark_%28black%29.svg/1200px-Question_mark_%28black%29.svg.png"
    var avatar_url: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Question_mark_%28black%29.svg/1200px-Question_mark_%28black%29.svg.png"
    var description: String = ""
    var follows = [UserFollow()]
}

struct UserFollow {
    var userID: String = ""
    var username: String = ""
    var followed_at: String = ""
}
