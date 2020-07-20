import SwiftUI
import SwiftyJSON
import RemoteImage

struct SettingsPage: View {
    @State private var userData = currUser.userData
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    HStack {
                        RemoteImage(type: .url(URL(string: userData.avatar_url)!), errorView: { error in
                            Text(error.localizedDescription)
                        }, imageView: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 64.0)
                        }, loadingView: {
                            Text("Loading...")
                        })
                        VStack {
                            Text(userData.name)
                                .font(.largeTitle)
                            Text("\(userData.views) views")
                        }
                    }
                    Text(userData.description)
                }
            }.navigationBarTitle("Settings")
        }
    }
    
    /*
    func loadData() { // gets personal data
        oauthswift.client.request(BASE_URL + "/users", method: .GET, headers: ["Client-ID": CLIENT_ID]) { result in
            switch result {
            case .success(let response):
                if let data = response.string!.data(using: .utf8) {
                    let json = try! JSON(data: data)
                    let parsed = json["data"][0]
                    
                    DispatchQueue.main.async {
                        userData.id = parsed["id"].string!
                        userData.name = parsed["display_name"].string!
                        userData.views = parsed["view_count"].int!
                        userData.offline_image_url = parsed["offline_image_url"].string!
                        userData.avatar_url = parsed["profile_image_url"].string!
                        userData.description = parsed["description"].string!
                    }
                }
            case .failure(let error):
                print("Users error: \(error)")
            }
        }
    }
     */
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
