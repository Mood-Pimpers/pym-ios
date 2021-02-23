import Explorer
import Home
import Insights
import Settings
import SwiftUI

struct RootView: View {
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
                    Spacer()
                    ExplorerView()
                        .tabItem { Image.explorer }
                    SettingsView()
                        .tabItem { Image.settings }
                }
                .accentColor(.primaryColor)

                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.primaryColor)
                        .frame(width: 60, height: 60)
                        .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 1)
                    Image.add
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                .offset(x: geometry.size.width / 2 - 30, y: geometry.size.height - 70)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
