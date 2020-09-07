import SwiftUI
import SwiftyJSON
import RemoteImage

struct SettingsPage: View {
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    RemoteImage(type: .url(URL(string: currUser.userData.avatar_url)!), errorView: { error in
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
                        Text(currUser.userData.display_name)
                            .font(.largeTitle)
                        currUser.userData.views == 1 ? Text("1 view") : Text("\(currUser.userData.views) views")
                    }
                }
                Text(currUser.userData.description)
            }
            Text("Unwood for Twitch")
                .fontWeight(.bold)
        }
    }
}
