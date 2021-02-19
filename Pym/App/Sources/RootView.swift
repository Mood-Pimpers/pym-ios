import CheckIn
import Explorer
import Home
import Insights
import Settings
import SwiftUI

struct RootView: View {
    public init() {
        UITabBar.appearance().barTintColor = Asset.whiteColor.color
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                TabView {
                    HomeView()
                        .background(Color.backgroundColor)
                        .tabItem {
                            Image.home.colorMultiply(.blackColor)
                        }
                    InsightsView()
                        .tabItem {
                            Image.insights.renderingMode(.template).colorMultiply(.black)
                        }
                    CheckInView()
                        .tabItem {}
                    ExplorerView()
                        .tabItem {
                            Image.explorer.colorMultiply(.blackColor)
                        }
                    SettingsView()
                        .tabItem {
                            Image.settings.colorMultiply(.blackColor)
                        }
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
