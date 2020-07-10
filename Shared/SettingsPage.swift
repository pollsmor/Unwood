import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {
            List {
                Text("1")
                Text("2")
                Text("3")
            }.navigationBarTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
