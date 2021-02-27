import HealthKit
import PymCore

class ViewModelFactory {
    let healthStore = HKHealthStore()
    let defaults = UserDefaults.standard
    let notificationService = NotificationService.shared

    func makeHealthImportViewModel(
        next: @escaping () -> Void
    ) -> HealthImportViewModel {
        HealthImportViewModel(
            healthStore: healthStore,
            next: next
        )
    }

    func makeMoodReminderIntroViewModel(
        next: @escaping (NotificationAuthorizationStatus) -> Void
    ) -> MoodReminderIntroViewModel {
        MoodReminderIntroViewModel(
            defaults: defaults,
            notificationService: notificationService,
            next: next
        )
    }

    func makeMoodReminderSettingsViewModel(
        next: @escaping () -> Void
    ) -> MoodReminderSettingsViewModel {
        MoodReminderSettingsViewModel(
            defaults: defaults,
            notificationService: notificationService,
            next: next
        )
    }
}
