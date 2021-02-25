import PymCore
import SwiftUI

public struct OnboardingView: View {
    let viewModelFactory = ViewModelFactory()
    @AppStorage(Defaults.Keys.firstAppLaunch) var firstAppLaunch: Double = 0.0
    @State var currentIndex = 0

    public init() {}

    public var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            PickerPageView(pages: 4, currentIndex: $currentIndex, content: {
                WelcomeView(next: { currentIndex = 1 }).tag(0)
                HealthImportView(viewModel: viewModelFactory.makeHealthImportViewModel(), next: { currentIndex = 2 }).tag(1)
                MoodReminderIntroView(viewModel: viewModelFactory.makeMoodReminderIntroViewModel(), next: { currentIndex = 3 }).tag(2)
                MoodReminderSettingsView(next: {
                    firstAppLaunch = Date().timeIntervalSince1970
                }).tag(3)
            })
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}