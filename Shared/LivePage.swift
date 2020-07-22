import SwiftUI
import SwiftyJSON
import RemoteImage

struct LivePage: View {
    @EnvironmentObject var currUser: CurrentUser
    @State private var streams = [Stream]()
    
    var body: some View {
        if currUser.userData.id == "" {
            Text("Loading...")
        } else {
            NavigationView {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ForEach(streams) { stream in
                            NavigationLink(destination: StreamPage(channelName: stream.login).navigationBarTitle(stream.username, displayMode: .inline)) {
                                HStack(alignment: .top) {
                                    RemoteImage(type: .url(URL(string: stream.thumbnail_url)!), errorView: { error in
                                        Text(error.localizedDescription)
                                    }, imageView: { image in
                                        image
                                            .resizable()
                                            //.aspectRatio(contentMode: )
                                            .frame(width: 100.0, height: 60.0)
                                    }, loadingView: {
                                        Text("")
                                    })
                                    VStack(alignment: .leading) {
                                        Text(stream.username)
                                            .fontWeight(.bold)
                                        Text(stream.title)
                                            .lineLimit(2)
                                        Text("\(stream.viewer_count) viewers")
                                    }
                                }
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.buttonStyle(PlainButtonStyle())
                    .padding(8.0)
                }.frame(maxWidth: .infinity)
                .onAppear(perform: loadData)
                .navigationBarTitle("Streams")
            }
        }
    }
    
    func loadData() { // gets followed users
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
                    
                    var reqURL = BASE_URL + "/streams?"
                    if (followIDs.count > 0) {
                        for id in followIDs {
                            reqURL += "user_id=\(id)&"
                        }
                    }
                    
                    reqURL.removeLast() // remove last ampersand from for loop
                    
                    oauthswift.client.request(reqURL, method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
                        switch result {
                        case .success(let response):
                            if let data = response.string!.data(using: .utf8) {
                                let json = try! JSON(data: data)
                                let parsed = json["data"]
                                var streamsArr = [Stream]()
                                for el in parsed.arrayValue {
                                    var stream = Stream()
                                    stream.id = el["user_id"].string!
                                    stream.username = el["user_name"].string!
                                    stream.game_id = el["game_id"].string!
                                    stream.title = el["title"].string!
                                    stream.viewer_count = el["viewer_count"].int!
                                    stream.started_at = el["started_at"].string!
                                    stream.language = el["language"].string!
                                    
                                    // Get username and stream thumbnail
                                    stream.login = getUsernameFromThumbnailUrl(thumbnailUrl: el["thumbnail_url"].string!)
                                    stream.thumbnail_url = "https://static-cdn.jtvnw.net/previews-ttv/live_user_" + stream.login + "-200x100.jpg"
                                    streamsArr.append(stream)
                                }
                                
                                DispatchQueue.main.async {
                                    streams = streamsArr
                                }
                            }
                        case .failure(let error):
                            print("Unable to get streams error: \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("Unable to get follower IDs: \(error)")
            }
        }
    }
    
    func getUsernameFromThumbnailUrl(thumbnailUrl: String) -> String {
        let start = thumbnailUrl.index(thumbnailUrl.startIndex, offsetBy: 52)
        let end = thumbnailUrl.index(thumbnailUrl.endIndex, offsetBy: -21)
        let range = start..<end
        return String(thumbnailUrl[range])
    }
}

struct LivePage_Previews: PreviewProvider {
    static var previews: some View {
        LivePage()
    }
}
