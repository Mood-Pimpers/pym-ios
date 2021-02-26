import SwiftUI

public enum NotificationAuthorizationStatus {
    case notAsked
    case allowed
    case notAllowed
}

public enum Notification {
    public enum Identifier: String {
        case notifyMorning = "notify.morning"
        case notifyEvening = "notify.evening"
    }
}

public class NotificationService: ObservableObject {
    public static let shared = NotificationService()

    private let notificationCenter = UNUserNotificationCenter.current()
    private let defaults = UserDefaults.standard

    @Published public var status = NotificationAuthorizationStatus.notAsked

    private var morningNotification: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Good morning"
        content.subtitle = "Enter your morning entry"
        content.sound = UNNotificationSound.default
        return content
    }

    private var eveningNotification: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Good evening"
        content.subtitle = "Enter your evening entry"
        content.sound = UNNotificationSound.default
        return content
    }

    private init() {
        // If the notification authorization as requested before the
        // requestAuthorization call is used to determine the current status ( see: `NotificationAuthorizationStatus`)
        if defaults.wasNotificationAuthRequested {
            requestAuthorization()
        }
    }

    public func requestAuthorization(
        completion: ((_ status: NotificationAuthorizationStatus) -> Void)? = nil
    ) {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            let status: NotificationAuthorizationStatus
            if success {
                status = .allowed
            } else if let error = error {
                status = .notAllowed
                print(error.localizedDescription)
            } else {
                status = .notAllowed
            }

            self.defaults.setNotificationAuthRequested()
            self.status = status

            if let completion = completion {
                completion(status)
            }
        }
    }

    public func schedule(identifier: Notification.Identifier, on time: Date, content: UNMutableNotificationContent) {
        func schedule() {
            var date = DateComponents()
            date.hour = time.hour
            date.minute = time.minute

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: date,
                repeats: true
            )

            let request = UNNotificationRequest(
                identifier: identifier.rawValue,
                content: content,
                trigger: trigger
            )

            notificationCenter.add(request)
        }

        if status == .notAsked {
            requestAuthorization(completion: { _ in
                schedule()
            })
        } else {
            schedule()
        }
    }

    public func remove(withIdentifier identifier: Notification.Identifier) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier.rawValue])
    }

    public func scheduleNotifyMorning(isEnabled: Bool, on time: Date) {
        remove(withIdentifier: Notification.Identifier.notifyMorning)
        if isEnabled {
            schedule(identifier: Notification.Identifier.notifyMorning, on: time, content: morningNotification)
        }
    }

    public func scheduleNotifyEvening(isEnabled: Bool, on time: Date) {
        remove(withIdentifier: Notification.Identifier.notifyEvening)
        if isEnabled {
            schedule(identifier: Notification.Identifier.notifyEvening, on: time, content: eveningNotification)
        }
    }
}
