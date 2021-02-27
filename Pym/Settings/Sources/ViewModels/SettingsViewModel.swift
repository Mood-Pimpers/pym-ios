import PymCore
import SwiftUI

class SettingsViewModel: ObservableObject {
    private let dataAccess = DataAccessController.shared
    private let notificationService = NotificationService.shared
    private let defaults = UserDefaults.standard

    @Published var morning: EnableTimeViewModel
    @Published var evening: EnableTimeViewModel

    @Published var showEreaseAllWarning = false

    init() {
        morning = EnableTimeViewModel(
            isEnabled: defaults.notifyMorningEnabled,
            notifyOn: defaults.notifyMorningTime
        )

        evening = EnableTimeViewModel(
            isEnabled: defaults.notifyEveningEnabled,
            notifyOn: defaults.notifyEveningTime
        )

        morning.onChange = updateMorning
        evening.onChange = updateEvening
    }

    private func updateMorning() {
        defaults.setNotifyMorning(isEnabled: morning.isEnabled, on: morning.time)
        notificationService.scheduleNotifyMorning(isEnabled: morning.isEnabled, on: morning.time)
    }

    private func updateEvening() {
        defaults.setNotifyEvening(isEnabled: evening.isEnabled, on: evening.time)
        notificationService.scheduleNotifyEvening(isEnabled: evening.isEnabled, on: evening.time)
    }

    func ereaseAllData() {
        dataAccess.deleteAllEntries()
    }
}
