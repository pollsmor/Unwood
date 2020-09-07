import SwiftUI
import SwiftyJSON
import RemoteImage

struct SettingsPage: View {
    @State private var userData = currUser.userData
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    RemoteImage(type: .url(URL(string: userData.avatar_url)!), errorView: { error in
                    }, imageView: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64.0)
                    }, loadingView: {
                        ProgressView()
                            .frame(width: 64.0)
                    })
                    VStack(alignment: .leading) {
                        Text(userData.display_name)
                            .font(.largeTitle)
                        userData.views == 1 ? Text("1 view") : Text("\(userData.views) views")
                    }
                }
                Text(userData.description)
            }
            Text("Unwood for Twitch")
                .fontWeight(.bold)
        }
    }
}
