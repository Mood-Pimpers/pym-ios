import PymCore
import SwiftUI

class MoodReminderIntroViewModel: ObservableObject {
    private let defaults: UserDefaults
    private let notificationService: NotificationService
    let next: (_ status: NotificationAuthorizationStatus) -> Void

    @Published var showAlert = false

    init(
        defaults: UserDefaults,
        notificationService: NotificationService,
        next: @escaping (_ status: NotificationAuthorizationStatus) -> Void
    ) {
        self.defaults = defaults
        self.notificationService = notificationService
        self.next = next
    }

    func toggleNotificationWarning() {
        showAlert = true
    }

    func continueWithNotifications() {
        notificationService.requestAuthorization(completion: next)
    }

    func continueWithoutNotifications() {
        next(.notAsked)
    }
}
