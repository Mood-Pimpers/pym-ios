import CheckIn
import Explorer
import Home
import Insights
import Onboarding
import PymCore
import Settings
import SwiftUI

struct RootView: View {
    @ObservedObject private var modalService = ModalService.shared
    @AppStorage(UserDefaults.Keys.firstAppLaunch.rawValue) var firstAppLaunch: Double = 0.0

    public init() {
        UITabBar.appearance().barTintColor = Asset.whiteColor.color
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }

    var body: some View {
        if firstAppLaunch == 0.0 {
            OnboardingView()
        } else {
            ZStack {
                GeometryReader { geometry in
                    TabView {
                        HomeView()
                            .tabItem { Image.home }
                        InsightsView()
                            .tabItem { Image.insights }
                        Text("")
                            .tabItem {}
                        ExplorerView()
                            .tabItem { Image.explorer }
                        SettingsView()
                            .tabItem { Image.settings }
                    }
                    .accentColor(.primaryColor)

                    Button(
                        action: modalService.toggleMoodCheckin,
                        label: {
                            Image.add
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                    )
                    .buttonStyle(PrimaryButtonStyle())
                    .offset(x: geometry.size.width / 2 - 30, y: geometry.size.height - 70)
                    .sheet(isPresented: $modalService.showMoodCheckin, content: CheckInModalView.init)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
