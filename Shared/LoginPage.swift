import SwiftUI

struct LoginPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Unwood for Twitch")
                    .font(.largeTitle)
                    .padding()
                Button(action: twitchapi.signIn) {
                    Text("Sign in")
                        .font(.title)
                }
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
