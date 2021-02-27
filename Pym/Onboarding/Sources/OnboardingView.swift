import PymCore
import SwiftUI

public struct OnboardingView: View {
    let viewModelFactory = ViewModelFactory()
    @AppStorage(UserDefaults.Keys.firstAppLaunch.rawValue) var firstAppLaunch: Double = 0.0
    @State var currentPage = OnboardingPage.welcome

    public init() {}

    public var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            PickerPageView(currentPage: $currentPage) {
                WelcomeView(
                    next: { currentPage = .healthImport })
                    .tag(OnboardingPage.welcome)
                    .disableDrag()

                HealthImportView(
                    viewModel: viewModelFactory.makeHealthImportViewModel(
                        next: { currentPage = .moodReminderIntro }))
                    .tag(OnboardingPage.healthImport)
                    .disableDrag()

                MoodReminderIntroView(
                    viewModel: viewModelFactory.makeMoodReminderIntroViewModel(
                        next: notificationStep))
                    .tag(OnboardingPage.moodReminderIntro)
                    .disableDrag()

                MoodReminderSettingsView(
                    viewModel: viewModelFactory.makeMoodReminderSettingsViewModel(
                        next: finish))
                    .tag(OnboardingPage.moodReminderSettings)
                    .disableDrag()
            }
        }
    }

    private func notificationStep(status: NotificationAuthorizationStatus) {
        switch status {
        case .notAsked, .notAllowed: finish()
        case .allowed: currentPage = .moodReminderSettings
        }
    }

    private func finish() {
        firstAppLaunch = Date().timeIntervalSince1970
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
