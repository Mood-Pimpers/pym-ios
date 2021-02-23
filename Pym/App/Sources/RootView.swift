import CheckIn
import Explorer
import Home
import Insights
import PymCore
import Settings
import SwiftUI

struct RootView: View {
    @State private var showMoodCheckin = false

    public init() {
        UITabBar.appearance().barTintColor = Asset.whiteColor.color
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                TabView {
                    HomeView()
                        .tabItem { Image.home }
                    InsightsView()
                        .tabItem { Image.insights }
                    Text("TODO: Add alert")
                        .tabItem {}
                    ExplorerView()
                        .tabItem { Image.explorer }
                    SettingsView()
                        .tabItem { Image.settings }
                }
                .accentColor(.primaryColor)

                Button(action: toggleMoodCheckin, label: {
                    Image.add
                        .resizable()
                        .frame(width: 28, height: 28)
                })
                    .buttonStyle(PrimaryButtonStyle())
                    .onTapGesture(perform: toggleMoodCheckin)
                    .offset(x: geometry.size.width / 2 - 30, y: geometry.size.height - 70)
                    .sheet(isPresented: $showMoodCheckin, content: CheckInModalView.init)
            }
        }
    }

    private func toggleMoodCheckin() {
        showMoodCheckin.toggle()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
