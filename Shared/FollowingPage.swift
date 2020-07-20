import SwiftUI
import SwiftyJSON

struct FollowingPage: View {
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        if currUser.userData.id == "" {
            Text("Loading...")
        } else {
            NavigationView {
                List {
                    
                }.navigationBarTitle("Followed channels")
                 .onAppear(perform: loadData)
            }
        }
    }
    
    func loadData() { // gets followed users
        oauthswift.client.request(BASE_URL + "/users/follows?from_id=" + currUser.userData.id, method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
            switch result {
            case .success(let response):
                if let data = response.string!.data(using: .utf8) {
                    let json = try! JSON(data: data)
                    let parsed = json["data"]
                    var follows = [UserFollow()]
                    for el in parsed.arrayValue {
                        print(el)
                        var follow = UserFollow()
                        follow.userID = el["from_id"].string!
                        follow.username = el["from_name"].string!
                        follow.followed_at = el["followed_at"].string!
                        follows.append(follow)
                    }
                    
                    DispatchQueue.main.async {
                        currUser.userData.follows = follows
                    }
                }
            case .failure(let error):
                print("Unable to get follows error: \(error)")
            }
        }
    }
}

struct FollowingPage_Previews: PreviewProvider {
    static var previews: some View {
        FollowingPage()
    }
}
