import SwiftUI

struct SettingsPage: View {
    @State private var userData = currUser.userData
    
    var body: some View {
        NavigationView {
            List {
                Button(action: twitchapi.getPersonalData) {
                    Text("Get data")
                }
                Text("1")
                Text("2")
                Text("3")
            }.navigationBarTitle("Settings")
        }
    }
    
    func loadData() {
        
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
