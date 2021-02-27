import PymCore
import SwiftUI

class MoodReminderSettingsViewModel: ObservableObject {
    private let defaults: UserDefaults
    private let notificationService: NotificationService
    private let next: () -> Void

    @Published var morning: EnableTimeViewModel
    @Published var evening: EnableTimeViewModel

    init(
        defaults: UserDefaults,
        notificationService: NotificationService,
        next: @escaping () -> Void
    ) {
        self.defaults = defaults
        self.notificationService = notificationService
        self.next = next

        morning = EnableTimeViewModel(
            isEnabled: true,
            notifyOn: defaults.notifyMorningTime
        )

        evening = EnableTimeViewModel(
            isEnabled: true,
            notifyOn: defaults.notifyEveningTime
        )
    }

    func saveAndNext() {
        updateMorning()
        updateEvening()
        next()
    }

    private func updateMorning() {
        defaults.setNotifyMorning(isEnabled: morning.isEnabled, on: morning.time)
        notificationService.scheduleNotifyMorning(isEnabled: morning.isEnabled, on: morning.time)
    }

    private func updateEvening() {
        defaults.setNotifyEvening(isEnabled: evening.isEnabled, on: evening.time)
        notificationService.scheduleNotifyEvening(isEnabled: evening.isEnabled, on: evening.time)
    }
}
