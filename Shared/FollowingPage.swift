import SwiftUI
import SwiftyJSON
import RemoteImage

struct FollowingPage: View {
    @EnvironmentObject var currUser: CurrentUser
    @State private var followedChannels = [User]()
    
    var body: some View {
        if currUser.userData.id == "" {
            ProgressView()
        } else {
            NavigationView {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ForEach(followedChannels) { follow in
                            HStack {
                                RemoteImage(type: .url(URL(string: follow.avatar_url)!), errorView: { error in
                                }, imageView: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 32.0)
                                }, loadingView: {
                                    ProgressView()
                                        .frame(width: 32.0)
                                })
                                Text(follow.display_name)
                                    .font(.title)
                            }
                        }
                    }.frame(maxWidth: .infinity)
                     .onAppear(perform: loadData)
                }.navigationBarTitle("Followed channels")
            }
        }
    }
    
    private func loadData() { // gets followed users
        var followIDs = [String]()
        
        oauthswift.client.request(BASE_URL + "/users/follows?first=100&from_id=" + currUser.userData.id, method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
            switch result {
            case .success(let response):
                if let data = response.string!.data(using: .utf8) {
                    let json = try! JSON(data: data)
                    let parsed = json["data"]
                    for el in parsed.arrayValue {
                        followIDs.append(el["to_id"].string!)
                    }
                    
                    var reqURL = BASE_URL + "/users?"
                    if (followIDs.count > 0) {
                        for id in followIDs {
                            reqURL += "id=\(id)&"
                        }
                    }
                    
                    reqURL.removeLast() // remove last ampersand from for loop
                    
                    oauthswift.client.request(reqURL, method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
                        switch result {
                        case .success(let response):
                            if let data = response.string!.data(using: .utf8) {
                                let json = try! JSON(data: data)
                                let parsed = json["data"]
                                var followedArr = [User]()
                                for el in parsed.arrayValue {
                                    var follow = User()
                                    follow.id = el["id"].string!
                                    follow.display_name = el["display_name"].string!
                                    follow.login = el["login"].string!
                                    follow.views = el["view_count"].int!
                                    follow.offline_image_url = el["offline_image_url"].string!
                                    follow.avatar_url = el["profile_image_url"].string!
                                    follow.description = el["description"].string!
                                    followedArr.append(follow)
                                }
                                
                                DispatchQueue.main.async {
                                    followedChannels = followedArr
                                }
                            }
                        case .failure(let error):
                            print("Unable to get follows error: \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("Unable to get follower IDs: \(error)")
            }
        }
    }
}
