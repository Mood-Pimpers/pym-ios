import PymCore
import SwiftUI

public struct OnboardingView: View {
    public init() {}

    public var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            PickerPageView(pages: 4, content: {
                WelcomeView(next: {})
                HealthImportView(next: {})
                MoodReminderIntroView(next: {})
                MoodReminderSettingsView(next: {})
            })
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
